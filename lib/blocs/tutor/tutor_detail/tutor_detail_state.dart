import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/tutor.dart';

abstract class TutorDetailState extends Equatable {}

class TutorDetailInitial extends TutorDetailState {
  @override
  List<Object> get props => [];
}

class TutorDetailLoading extends TutorDetailState {
  @override
  List<Object> get props => [];
}

class TutorDetailSuccess extends TutorDetailState {
  final Tutor tutor;

  TutorDetailSuccess(this.tutor);

  @override
  List<Object> get props => [tutor];
}

class TutorDetailFailure extends TutorDetailState {
  final String error;

  TutorDetailFailure(this.error);

  @override
  List<Object> get props => [error];
}
