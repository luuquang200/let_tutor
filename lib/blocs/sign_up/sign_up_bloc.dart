import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/sign_up/sign_up_event.dart';
import 'package:let_tutor/blocs/sign_up/sign_up_state.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository authenticationRepository;

  SignUpBloc({required this.authenticationRepository})
      : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RetypePasswordChanged>(_onRetypePasswordChanged);
  }

  void _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
      return;
    }

    if (event.password.isEmpty) {
      emit(PasswordInvalid('Password cannot be empty!'));
      return;
    }

    if (event.password != event.retypePassword) {
      emit(PasswordsDoNotMatch('Passwords do not match!'));
      return;
    }

    emit(SignUpLoading());
    try {
      await authenticationRepository.signUp(event.email, event.password);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
    } else if (!isValidEmail(event.email)) {
      emit(EmailInvalid('Invalid email format!'));
    } else {
      emit(EmailValid());
    }
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    if (event.password.isEmpty) {
      emit(PasswordInvalid('Password cannot be empty!'));
    } else {
      emit(PasswordValid());
    }
  }

  void _onRetypePasswordChanged(
      RetypePasswordChanged event, Emitter<SignUpState> emit) {
    if (event.retypePassword.isEmpty) {
      emit(PasswordInvalid('Retyped password cannot be empty!'));
    } else {
      emit(PasswordValid());
    }
  }
}

bool isValidEmail(String email) {
  return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
      .hasMatch(email);
}
