import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInSuccess extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInFailure extends SignInState {
  final String error;

  SignInFailure(this.error);

  @override
  List<Object> get props => [error];
}

class EmailInvalid extends SignInState {
  final String error;

  EmailInvalid(this.error);

  @override
  List<Object> get props => [error];
}

class EmailValid extends SignInState {
  @override
  List<Object> get props => [];
}

class PasswordInvalid extends SignInState {
  final String error;

  PasswordInvalid(this.error);

  @override
  List<Object> get props => [error];
}

class PasswordValid extends SignInState {
  @override
  List<Object> get props => [];
}
