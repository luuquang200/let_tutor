abstract class SignInEvent {}

class SignInSubmitted extends SignInEvent {
  final String email;
  final String password;

  SignInSubmitted({required this.email, required this.password});
}

class EmailChanged extends SignInEvent {
  final String email;

  EmailChanged({required this.email});
}

class PasswordChanged extends SignInEvent {
  final String password;

  PasswordChanged({required this.password});
}

class SignInWithGoogle extends SignInEvent {}

class SignInWithFacebook extends SignInEvent {}
