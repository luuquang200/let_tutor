import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/sign_in/sign_in_event.dart';
import 'package:let_tutor/blocs/sign_in/sign_in_state.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationRepository authenticationRepository;

  SignInBloc({required this.authenticationRepository})
      : super(SignInInitial()) {
    on<SignInSubmitted>((event, emit) async {
      emit(SignInLoading());
      try {
        print('email: ${event.email}, password: ${event.password}');
        await authenticationRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      } catch (_) {
        emit(SignInFailure('Invalid email or password'));
      }
    });

    on<EmailChanged>((event, emit) {
      if (event.email.isEmpty) {
        emit(EmailInvalid('Email cannot be empty !'));
      } else if (!_isValidEmail(event.email)) {
        emit(EmailInvalid('Invalid email format'));
      } else {
        emit(EmailValid());
      }
    });

    on<PasswordChanged>((event, emit) {
      if (event.password.isEmpty) {
        emit(PasswordInvalid('Password cannot be empty !'));
      } else {
        emit(PasswordValid());
      }
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }
}
