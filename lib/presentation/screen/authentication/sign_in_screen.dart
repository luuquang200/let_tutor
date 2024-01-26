import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_event.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_state.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/app_logo.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/custom_label.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/custom_text_field.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/social_login.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';
import 'package:let_tutor/routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          handleState(context, state);
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const AppLogo(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabel(text: 'email'.tr()),
                        CustomTextFieldAuth(
                          hintText: 'mail@example.com',
                          controller: _emailController,
                          onChanged: (value) {
                            context
                                .read<SignInBloc>()
                                .add(EmailChanged(email: value));
                          },
                          errorText: emailErrorText,
                          icon: Icons.mail,
                        ),
                        const SizedBox(height: 10),
                        CustomLabel(text: 'password'.tr()),
                        CustomTextFieldAuth(
                          hintText: 'password'.tr(),
                          controller: _passwordController,
                          obscureText: _obscureText,
                          onPressedHidePass: _togglePasswordVisibility,
                          onChanged: (value) {
                            context
                                .read<SignInBloc>()
                                .add(PasswordChanged(password: value));
                          },
                          showIcon: true,
                          errorText: passwordErrorText,
                          icon: Icons.lock,
                        ),
                        _navigateToForgotPass(context),
                        _loginButton(context),
                        _labelLoginWithSocial(),
                        const SocialLogin(),
                        _navigateToSignUp(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextButton _navigateToForgotPass(BuildContext context) {
    return TextButton(
      onPressed: () {
        Routes.navigateToReplacement(context, Routes.forgotPasswordScreen);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(top: 20, bottom: 15),
      ),
      child: Text(
        'forgot_password'.tr(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
    );
  }

  Container _labelLoginWithSocial() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      child: Text(
        'or_continue_with'.tr(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Row _navigateToSignUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('not_a_member_yet'.tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            )),
        TextButton(
          onPressed: () {
            Routes.navigateToReplacement(context, Routes.signUpScreen);
          },
          child: Text('sign_up'.tr(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              )),
        ),
      ],
    );
  }

  MyElevatedButton _loginButton(BuildContext context) {
    return MyElevatedButton(
      text: 'login'.tr(),
      height: 52,
      radius: 8,
      onPressed: () {
        context.read<SignInBloc>().add(
              SignInSubmitted(
                email: _emailController.text,
                password: _passwordController.text,
              ),
            );
      },
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void handleState(BuildContext context, SignInState state) {
    if (state is EmailInvalid) {
      emailErrorText = state.error;
    } else if (state is EmailValid) {
      emailErrorText = null;
    } else if (state is PasswordInvalid) {
      passwordErrorText = state.error;
    } else if (state is PasswordValid) {
      passwordErrorText = null;
    } else if (state is SignInLoading) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('signing_in'.tr()),
        ),
      );
    } else if (state is SignInSuccess) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Routes.navigateToReplacement(context, Routes.home);
    } else if (state is SignInFailure) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error),
        ),
      );
    }
  }
}
