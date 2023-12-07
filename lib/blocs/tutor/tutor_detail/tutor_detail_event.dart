import 'package:equatable/equatable.dart';

abstract class TutorDetailEvent extends Equatable {}

class TutorDetailRequested extends TutorDetailEvent {
  final String tutorId;

  TutorDetailRequested({required this.tutorId});

  @override
  List<Object> get props => [tutorId];
}

class FavouriteTutorEvent extends TutorDetailEvent {
  final String tutorId;

  FavouriteTutorEvent({required this.tutorId});

  @override
  List<Object> get props => [tutorId];
}

class ReportTutorEvent extends TutorDetailEvent {
  final String tutorId;
  final String content;

  ReportTutorEvent({required this.tutorId, required this.content});

  @override
  List<Object> get props => [tutorId, content];
}
