import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/auth/forgot_password/forgot_password_event.dart';
import 'package:let_tutor/blocs/auth/forgot_password/forgot_password_state.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthenticationRepository authenticationRepository;

  ForgotPasswordBloc({required this.authenticationRepository})
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<EmailChanged>(_onEmailChanged);
  }

  void _onForgotPasswordSubmitted(
      ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
      return;
    } else if (!isValidEmail(event.email)) {
      emit(EmailInvalid('Invalid email format!'));
      return;
    } else {
      emit(ForgotPasswordLoading());
      try {
        await authenticationRepository.sendPasswordResetEmail(event.email);
        emit(ForgotPasswordSuccess());
      } catch (e) {
        emit(ForgotPasswordFailure(e.toString()));
      }
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<ForgotPasswordState> emit) {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
    } else if (!isValidEmail(event.email)) {
      emit(EmailInvalid('Invalid email format!'));
    } else {
      emit(EmailValid());
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }
}
