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
  final Map<String, dynamic> filters;

  TutorListSuccess(this.tutors, this.filters);

  @override
  List<Object> get props => [tutors, filters];
}

class TutorListFailure extends TutorListState {
  final String error;

  TutorListFailure(this.error);

  @override
  List<Object> get props => [error];
}
