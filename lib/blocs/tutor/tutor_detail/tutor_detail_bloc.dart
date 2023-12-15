import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_state.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class TutorDetailBloc extends Bloc<TutorDetailEvent, TutorDetailState> {
  final TutorRepository tutorRepository;

  TutorDetailBloc({required this.tutorRepository})
      : super(TutorDetailInitial()) {
    on<TutorDetailRequested>(_onTutorDetailRequested);
    on<FavouriteTutorEvent>(_onFavouriteTutor);
    on<ReportTutorEvent>(_onReportTutor);
  }

  FutureOr<void> _onTutorDetailRequested(
      TutorDetailRequested event, Emitter<TutorDetailState> emit) async {
    emit(TutorDetailLoading());
    try {
      final tutor = await tutorRepository.getTutorById(event.tutorId);

      emit(TutorDetailSuccess(tutor, DateTime.now()));
    } catch (error) {
      emit(TutorDetailFailure(error.toString()));
    }
  }

  FutureOr<void> _onFavouriteTutor(
      FavouriteTutorEvent event, Emitter<TutorDetailState> emit) async {
    log('Clicked favorite');
    try {
      var response = await tutorRepository.favouriteTutor(event.tutorId);
      log('tutorId: ${event.tutorId}');
      if (response) {
        if (state is TutorDetailSuccess) {
          final currentState = state as TutorDetailSuccess;
          final updatedTutor = currentState.tutor
              .copyWith(isFavorite: !(currentState.tutor.isFavorite ?? false));
          emit(TutorDetailSuccess(updatedTutor, DateTime.now()));
          log('message: ${updatedTutor.isFavorite}');
          log('Favorite success');
        }
      }
    } catch (error) {
      emit(TutorDetailFailure(error.toString()));
    }
  }

  FutureOr<void> _onReportTutor(
      ReportTutorEvent event, Emitter<TutorDetailState> emit) async {
    try {
      await tutorRepository.reportTutor(event.tutorId, event.content);
    } catch (error) {
      emit(TutorDetailFailure(error.toString()));
    }
  }
}
