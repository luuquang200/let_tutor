import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class EmailInvalid extends ForgotPasswordState {
  final String error;

  EmailInvalid(this.error);

  @override
  List<Object> get props => [error];
}

class EmailValid extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;

  ForgotPasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
