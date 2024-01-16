import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_bloc.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';

List<RepositoryProvider> buildAuthRepositories() {
  return [
    RepositoryProvider<AuthenticationRepository>(
      create: (context) => AuthenticationRepository(),
    ),
  ];
}

List<BlocProvider> buildAuthBlocs(BuildContext context) {
  return [
    BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
    ),
    BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
    ),
  ];
}
