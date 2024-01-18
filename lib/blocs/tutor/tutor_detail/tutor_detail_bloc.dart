import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_state.dart';
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
      var learnTopics = await tutorRepository.getLearnTopic();
      var testPreparations = await tutorRepository.getTestPreparation();
      var listLanguages = await tutorRepository.getListLanguages();

      emit(TutorDetailSuccess(
          tutor, DateTime.now(), learnTopics, testPreparations, listLanguages));
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
          emit(TutorDetailSuccess(
              updatedTutor,
              DateTime.now(),
              currentState.learnTopics,
              currentState.testPreparations,
              currentState.categories,
              updateFavoriteSuccess: true,
              reportSuccess: false));
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
      log('Report tutor');
      await tutorRepository.reportTutor(event.tutorId, event.content);
      log('Report success');
      if (state is TutorDetailSuccess) {
        final currentState = state as TutorDetailSuccess;
        emit(currentState.copyWith(
            reportSuccess: true, updateFavoriteSuccess: false));
      }
    } catch (error) {
      emit(TutorDetailFailure(error.toString()));
    }
  }
}
