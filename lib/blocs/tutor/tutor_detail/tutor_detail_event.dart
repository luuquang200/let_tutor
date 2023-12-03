import 'package:equatable/equatable.dart';

abstract class TutorDetailEvent extends Equatable {}

class TutorDetailRequested extends TutorDetailEvent {
  final String tutorId;

  TutorDetailRequested({required this.tutorId});

  @override
  List<Object> get props => [tutorId];
}
