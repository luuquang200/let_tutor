import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_event.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_state.dart';
import 'package:let_tutor/data/models/user/authentication_response.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';
import 'package:let_tutor/data/sharedpref/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationRepository authenticationRepository;
  final GoogleSignIn googleSignIn;
  late SharedPreferenceHelper sharedPrefsHelper;

  SignInBloc({required this.authenticationRepository})
      : googleSignIn = GoogleSignIn(),
        super(SignInInitial()) {
    _getPres();
    on<SignInSubmitted>(_onSignInSubmitted);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignInWithFacebook>(_onSignInWithFacebook);
  }

  void _getPres() async {
    sharedPrefsHelper =
        SharedPreferenceHelper(await SharedPreferences.getInstance());
  }

  void _onSignInSubmitted(
      SignInSubmitted event, Emitter<SignInState> emit) async {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
      return;
    }

    if (!isValidEmail(event.email)) {
      emit(EmailInvalid('Invalid email format!'));
      return;
    }

    if (event.password.isEmpty) {
      emit(PasswordInvalid('Password cannot be empty!'));
      return;
    }

    emit(SignInLoading());
    try {
      AuthenticationResponse loginResponse =
          await authenticationRepository.signIn(event.email, event.password);

      String accessToken = loginResponse.tokens.access.token;
      String refreshToken = loginResponse.tokens.refresh.token;

      log('accessToken: $accessToken');
      log('refreshToken: $refreshToken');

      // Save the tokens for later use
      await saveTokens(accessToken, refreshToken);

      emit(SignInSuccess());
    } catch (e) {
      log('error from bloc: $e');
      emit(SignInFailure(e.toString()));
    }
  }

  void _onSignInWithGoogle(
      SignInWithGoogle event, Emitter<SignInState> emit) async {
    emit(SignInLoading());
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      log('accessToken: ${googleAuth.accessToken}');
      // Send these tokens to server
      final String accessToken = googleAuth.accessToken!;
      AuthenticationResponse result =
          await authenticationRepository.signInWithGoogle(accessToken);

      // Save the tokens for later use
      await saveTokens(result.tokens.access.token, result.tokens.refresh.token);

      log('google sign in');

      emit(SignInSuccess());
    } catch (e) {
      log('error from bloc: $e');
      emit(SignInFailure(e.toString()));
    }
  }

  // void _onSignInWithGoogle(
  //     SignInWithGoogle event, Emitter<SignInState> emit) async {
  //   emit(SignInLoading());
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  //     GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //     GoogleSignInAuthentication? authentication =
  //         await googleSignInAccount?.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: authentication?.accessToken,
  //       idToken: authentication?.idToken,
  //     );
  //     final userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     // Use these credentials to authenticate with your server
  //     AuthenticationResponse result = await authenticationRepository
  //         .signInWithGoogle(userCredential.credential?.accessToken ?? '');

  //     // Save the tokens for later use
  //     await saveTokens(result.tokens.access.token, result.tokens.refresh.token);

  //     log('google sign in');

  //     emit(SignInSuccess());
  //   } catch (e) {
  //     log('error from bloc: $e');
  //     emit(SignInFailure(e.toString()));
  //   }
  // }

  void _onSignInWithFacebook(
      SignInWithFacebook event, Emitter<SignInState> emit) {
    emit(SignInLoading());
    try {
      // AuthenticationResponse loginResponse =
      //     await authenticationRepository.signIn(event.email, event.password);

      // String accessToken = loginResponse.tokens.access.token;
      // String refreshToken = loginResponse.tokens.refresh.token;

      // log('accessToken: $accessToken');
      // log('refreshToken: $refreshToken');

      // // Save the tokens for later use
      // await saveTokens(accessToken, refreshToken);
      // await saveUser(loginResponse.user);

      emit(SignInSuccess());
    } catch (e) {
      log('error from bloc: $e');
      emit(SignInFailure(e.toString()));
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignInState> emit) {
    if (event.email.isEmpty) {
      emit(EmailInvalid('Email cannot be empty!'));
    } else if (!isValidEmail(event.email)) {
      emit(EmailInvalid('Invalid email format!'));
    } else {
      emit(EmailValid());
    }
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignInState> emit) {
    if (event.password.isEmpty) {
      emit(PasswordInvalid('Password cannot be empty!'));
    } else {
      emit(PasswordValid());
    }
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    sharedPrefsHelper.saveAcessToken(accessToken);
    sharedPrefsHelper.saveRefreshToken(refreshToken);
  }
}

bool isValidEmail(String email) {
  return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
      .hasMatch(email);
}
