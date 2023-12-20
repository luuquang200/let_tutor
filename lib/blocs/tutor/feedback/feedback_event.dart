import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {}

class FeedbackRequested extends FeedbackEvent {
  final String tutorId;

  FeedbackRequested({required this.tutorId});

  @override
  List<Object> get props => [tutorId];
}
