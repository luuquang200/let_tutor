//Create

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:let_tutor/blocs/forgot_password/forgot_password_event.dart';
import 'package:let_tutor/blocs/forgot_password/forgot_password_state.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String? emailErrorText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          handleState(context, state);
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _appLogo(),
                  const SizedBox(height: 20),
                  _mainTitle(context),
                  _subTitle(context),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _inputEmail(context),
                        const SizedBox(height: 20),
                        _sendEmailButton(context),
                        const SizedBox(height: 20),
                        _backSignIn(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Text _mainTitle(BuildContext context) {
    return Text(
      'Reset Password',
      style: CustomTextStyle.headlineMedium.copyWith(fontSize: 32),
    );
  }

  void handleState(BuildContext context, ForgotPasswordState state) {
    if (state is EmailInvalid) {
      emailErrorText = state.error;
    } else if (state is EmailValid) {
      emailErrorText = null;
    } else if (state is ForgotPasswordLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sending email...'),
        ),
      );
    } else if (state is ForgotPasswordSuccess) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sent!'),
        ),
      );
      Routes.navigateToReplacement(context, Routes.signInScreen);
    } else if (state is ForgotPasswordFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error),
        ),
      );
    }
  }

  Row _backSignIn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Remember your password?',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(164, 176, 190, 1),
            )),
        TextButton(
          onPressed: () {
            Routes.navigateToReplacement(context, Routes.signInScreen);
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(0, 88, 198, 1),
            ),
          ),
        ),
      ],
    );
  }

  MyElevatedButton _sendEmailButton(BuildContext context) {
    return MyElevatedButton(
      onPressed: () {
        context.read<ForgotPasswordBloc>().add(
              ForgotPasswordSubmitted(
                email: _emailController.text,
              ),
            );
      },
      text: 'Send Email',
      height: 52,
      radius: 8,
    );
  }

  Padding _appLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 100, bottom: 30),
      child: SvgPicture.asset(
        'assets/lettutor_logo.svg',
      ),
    );
  }

  TextField _inputEmail(BuildContext context) {
    return TextField(
      controller: _emailController,
      onChanged: (value) =>
          context.read<ForgotPasswordBloc>().add(EmailChanged(email: value)),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail, size: 26, color: Color(0xFF0058C6)),
        hintText: 'mail@example.com',
        hintStyle: const TextStyle(
          color: Color(0xFFB0B0B0),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFB0B0B0)),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorText: emailErrorText,
      ),
    );
  }

  _subTitle(BuildContext context) {
    return Text('Please enter your email address to search for your account.',
        style: CustomTextStyle.bodyRegular.copyWith(
          fontSize: 16,
          color: const Color.fromRGBO(164, 176, 190, 1),
        ));
  }
}
