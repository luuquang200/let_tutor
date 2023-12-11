abstract class ForgotPasswordEvent {}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordSubmitted({required this.email});
}

class EmailChanged extends ForgotPasswordEvent {
  final String email;

  EmailChanged({required this.email});
}
