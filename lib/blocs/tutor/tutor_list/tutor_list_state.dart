import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/tutor.dart';

abstract class TutorListState extends Equatable {}

class TutorListInitial extends TutorListState {
  @override
  List<Object> get props => [];
}

class TutorListLoading extends TutorListState {
  @override
  List<Object> get props => [];
}

class TutorListSuccess extends TutorListState {
  final List<Tutor> tutors;

  TutorListSuccess(this.tutors);

  @override
  List<Object> get props => [tutors];
}

class TutorListFailure extends TutorListState {
  final String error;

  TutorListFailure(this.error);

  @override
  List<Object> get props => [error];
}
