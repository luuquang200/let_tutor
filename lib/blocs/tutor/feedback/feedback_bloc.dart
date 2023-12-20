import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/feedback/feedback_event.dart';
import 'package:let_tutor/blocs/tutor/feedback/feedback_state.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final TutorRepository tutorRepository;

  FeedbackBloc({required this.tutorRepository}) : super(FeedbackInitial()) {
    on<FeedbackRequested>(_onFeedbackRequested);
  }

  FutureOr<void> _onFeedbackRequested(
      FeedbackRequested event, Emitter<FeedbackState> emit) async {
    emit(FeedbackLoading());
    try {
      log('fetching feedbacks for tutor: ${event.tutorId}');
      var feedbacks = await tutorRepository.getFeedbacks(event.tutorId);

      // log feedbacks
      for (var feedback in feedbacks) {
        log('feedback: ${feedback.content}');
      }

      emit(FeedbackSuccess(feedbacks));
    } catch (error) {
      emit(FeedbackFailure(error.toString()));
    }
  }
}
