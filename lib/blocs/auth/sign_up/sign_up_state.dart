import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpSuccess extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);

  @override
  List<Object> get props => [error];
}

class EmailInvalid extends SignUpState {
  final String error;

  EmailInvalid(this.error);

  @override
  List<Object> get props => [error];
}

class EmailValid extends SignUpState {
  @override
  List<Object> get props => [];
}

class PasswordInvalid extends SignUpState {
  final String error;

  PasswordInvalid(this.error);

  @override
  List<Object> get props => [error];
}

class PasswordValid extends SignUpState {
  @override
  List<Object> get props => [];
}

class PasswordsDoNotMatch extends SignUpState {
  final String error;

  PasswordsDoNotMatch(this.error);

  @override
  List<Object> get props => [error];
}
