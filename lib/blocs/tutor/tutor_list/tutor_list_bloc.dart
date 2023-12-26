import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:let_tutor/data/models/schedule/booking.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/repositories/schedule_repository.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class TutorListBloc extends Bloc<TutorListEvent, TutorListState> {
  final TutorRepository tutorRepository;
  final ScheduleRepository scheduleRepository;
  final page = 1;
  final tutorPerPage = 12;
  String? tutorName;
  bool isReset = false;
  String selectedNationality = "";
  late BookedSchedule upcomingSchedule;

  TutorListBloc(
      {required this.tutorRepository, required this.scheduleRepository})
      : super(TutorListInitial()) {
    on<TutorListRequested>(_onTutorListRequested);
    on<FilterTutorsBySpeciality>(_onFilterTutorsBySpeciality);
    on<FilterTutorsByName>(_onFilterTutorsByName);
    on<FilterTutorsByNationality>(_onFilterTutorsByNationality);
    on<ResetFilters>(_onResetFilters);
  }

  FutureOr<void> _onTutorListRequested(
      TutorListRequested event, Emitter<TutorListState> emit) async {
    emit(TutorListLoading());
    try {
      final tutors = await tutorRepository.getTutors();
      List<LearnTopic> learnTopics = await tutorRepository.getLearnTopic();
      List<TestPreparation> testPreparations =
          await tutorRepository.getTestPreparation();

      List<BookedSchedule> bookedSchedules =
          await scheduleRepository.getBookedSchedule();

      log('bookedSchedules: $bookedSchedules');

      // Get the current timestamp
      int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

      // Filter out past schedules
      List<BookedSchedule> futureSchedules = bookedSchedules.where((schedule) {
        return schedule.scheduleDetailInfo!.startPeriodTimestamp! >
            currentTimestamp;
      }).toList();

      // Find the earliest schedule
      if (futureSchedules.isNotEmpty) {
        upcomingSchedule = futureSchedules.reduce((schedule1, schedule2) {
          return schedule1.scheduleDetailInfo!.startPeriodTimestamp! <
                  schedule2.scheduleDetailInfo!.startPeriodTimestamp!
              ? schedule1
              : schedule2;
        });
      } else {
        upcomingSchedule = BookedSchedule();
      }

      final Map<String, dynamic> filters = {}; // Initialize with no filters

      emit(TutorListSuccess(tutors, filters, learnTopics, testPreparations,
          isReset, selectedNationality, upcomingSchedule));
    } catch (error) {
      log('error from tutor list bloc: $error');
      emit(TutorListFailure(error.toString()));
    }
  }

  FutureOr<void> _onFilterTutorsBySpeciality(
      FilterTutorsBySpeciality event, Emitter<TutorListState> emit) async {
    final currentState = state;
    isReset = false;
    emit(TutorListLoading());
    try {
      if (currentState is TutorListSuccess) {
        log(' event.speciality: ${event.speciality}');

        final filters = Map<String, dynamic>.from(currentState.filters);
        filters['specialties'] = [
          event.speciality
        ]; // Update filters with new speciality filter
        log('filters - bloc: $filters');

        final filteredTutors = await tutorRepository.searchTutor(
            filters, page, tutorPerPage, tutorName);

        emit(currentState.copyWith(
            tutors: filteredTutors,
            filters: filters,
            isReset: isReset,
            selectedNationality: selectedNationality));
      }
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }

  FutureOr<void> _onFilterTutorsByName(
      FilterTutorsByName event, Emitter<TutorListState> emit) async {
    final currentState = state;
    isReset = false;
    tutorName = event.name;
    emit(TutorListLoading());
    try {
      if (currentState is TutorListSuccess) {
        final filters = Map<String, dynamic>.from(currentState.filters);
        final filteredTutors = await tutorRepository.searchTutor(
            filters, page, tutorPerPage, tutorName);

        emit(currentState.copyWith(
            tutors: filteredTutors,
            filters: filters,
            isReset: isReset,
            selectedNationality: selectedNationality));
      }
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }

  FutureOr<void> _onFilterTutorsByNationality(
      FilterTutorsByNationality event, Emitter<TutorListState> emit) async {
    final currentState = state;
    isReset = false;
    selectedNationality = event.selectedNationality;
    emit(TutorListLoading());
    try {
      if (currentState is TutorListSuccess) {
        final filters = Map<String, dynamic>.from(currentState.filters);
        filters['nationality'] = event.nationality;

        final filteredTutors = await tutorRepository.searchTutor(
            filters, page, tutorPerPage, tutorName);

        emit(currentState.copyWith(
            tutors: filteredTutors,
            filters: filters,
            isReset: isReset,
            selectedNationality: selectedNationality));
      }
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }

  FutureOr<void> _onResetFilters(
      ResetFilters event, Emitter<TutorListState> emit) async {
    emit(TutorListLoading());
    try {
      final tutors = await tutorRepository.getTutors();
      List<LearnTopic> learnTopics = await tutorRepository.getLearnTopic();
      List<TestPreparation> testPreparations =
          await tutorRepository.getTestPreparation();
      final Map<String, dynamic> filters = {}; // Initialize with no filters
      isReset = true;

      emit(TutorListSuccess(tutors, filters, learnTopics, testPreparations,
          isReset, selectedNationality, upcomingSchedule));
      tutorName = null;
    } catch (error) {
      log('error from tutor list bloc: $error');
      emit(TutorListFailure(error.toString()));
    }
  }
}
