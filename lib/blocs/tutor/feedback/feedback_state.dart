import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/tutors/feedback.dart';

abstract class FeedbackState extends Equatable {}

class FeedbackInitial extends FeedbackState {
  @override
  List<Object> get props => [];
}

class FeedbackLoading extends FeedbackState {
  @override
  List<Object> get props => [];
}

class FeedbackSuccess extends FeedbackState {
  final List<TutorFeedback> feedbacks;

  FeedbackSuccess(this.feedbacks);

  @override
  List<Object> get props => [feedbacks];
}

class FeedbackFailure extends FeedbackState {
  final String error;

  FeedbackFailure(this.error);

  @override
  List<Object> get props => [error];
}
