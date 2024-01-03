abstract class SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String retypePassword;

  SignUpSubmitted({
    required this.email,
    required this.password,
    required this.retypePassword,
  });
}

class EmailChanged extends SignUpEvent {
  final String email;

  EmailChanged({required this.email});
}

class PasswordChanged extends SignUpEvent {
  final String password;

  PasswordChanged({required this.password});
}

class RetypePasswordChanged extends SignUpEvent {
  final String retypePassword;

  RetypePasswordChanged({required this.retypePassword});
}
