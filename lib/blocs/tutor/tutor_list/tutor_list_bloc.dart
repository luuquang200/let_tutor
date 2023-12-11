import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class TutorListBloc extends Bloc<TutorListEvent, TutorListState> {
  final TutorRepository tutorRepository;
  final page = 1;
  final tutorPerPage = 10;

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
      final Map<String, dynamic> filters = {}; // Initialize with no filters

      emit(TutorListSuccess(tutors, filters));
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }

  FutureOr<void> _onFilterTutorsBySpeciality(
      FilterTutorsBySpeciality event, Emitter<TutorListState> emit) async {
    final currentState = state;
    emit(TutorListLoading());
    try {
      if (currentState is TutorListSuccess) {
        final filters = Map<String, dynamic>.from(currentState.filters);
        filters['speciality'] =
            event.speciality; // Update filters with new speciality filter

        final filteredTutors =
            await tutorRepository.filterTutors(filters, page, tutorPerPage);

        emit(TutorListSuccess(filteredTutors, filters));
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
        filters['name'] = event.name; // Update filters with new name filter

        final filteredTutors =
            await tutorRepository.filterTutors(filters, page, tutorPerPage);

        emit(TutorListSuccess(filteredTutors, filters));
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

        emit(TutorListSuccess(filteredTutors, filters));
      }
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }
}
