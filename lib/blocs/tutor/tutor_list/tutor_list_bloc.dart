import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class TutorListBloc extends Bloc<TutorListEvent, TutorListState> {
  final TutorRepository tutorRepository;
  final page = 1;
  final tutorPerPage = 12;
  String? tutorName;

  TutorListBloc({required this.tutorRepository}) : super(TutorListInitial()) {
    on<TutorListRequested>(_onTutorListRequested);
    on<FilterTutorsBySpeciality>(_onFilterTutorsBySpeciality);
    on<FilterTutorsByName>(_onFilterTutorsByName);
    on<FilterTutorsByNationality>(_onFilterTutorsByNationality);
  }

  FutureOr<void> _onTutorListRequested(
      TutorListRequested event, Emitter<TutorListState> emit) async {
    emit(TutorListLoading());
    try {
      final tutors = await tutorRepository.getTutors();
      List<LearnTopic> learnTopics = await tutorRepository.getLearnTopic();
      List<TestPreparation> testPreparations =
          await tutorRepository.getTestPreparation();

      final Map<String, dynamic> filters = {}; // Initialize with no filters

      emit(TutorListSuccess(tutors, filters, learnTopics, testPreparations));
    } catch (error) {
      log('error from tutor list bloc: $error');
      emit(TutorListFailure(error.toString()));
    }
  }

  FutureOr<void> _onFilterTutorsBySpeciality(
      FilterTutorsBySpeciality event, Emitter<TutorListState> emit) async {
    final currentState = state;
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

        emit(TutorListSuccess(filteredTutors, filters, currentState.learnTopics,
            currentState.testPreparations));
      }
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }

  FutureOr<void> _onFilterTutorsByName(
      FilterTutorsByName event, Emitter<TutorListState> emit) async {
    final currentState = state;
    emit(TutorListLoading());
    try {
      if (currentState is TutorListSuccess) {
        final filters = Map<String, dynamic>.from(currentState.filters);
        final filteredTutors = await tutorRepository.searchTutor(
            filters, page, tutorPerPage, event.name);

        emit(TutorListSuccess(filteredTutors, filters, currentState.learnTopics,
            currentState.testPreparations));
      }
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }

  FutureOr<void> _onFilterTutorsByNationality(
      FilterTutorsByNationality event, Emitter<TutorListState> emit) async {
    final currentState = state;
    emit(TutorListLoading());
    try {
      if (currentState is TutorListSuccess) {
        final filters = Map<String, dynamic>.from(currentState.filters);
        filters['nationality'] = event.nationality;
        log(filters.toString());

        final filteredTutors =
            await tutorRepository.filterTutors(filters, page, tutorPerPage);

        emit(TutorListSuccess(filteredTutors, filters, currentState.learnTopics,
            currentState.testPreparations));
      }
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }
}
