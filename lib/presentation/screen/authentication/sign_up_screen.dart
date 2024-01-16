import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_event.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_state.dart';
import 'package:let_tutor/presentation/screen/authentication/widgets/app_logo.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';
import 'package:let_tutor/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;
  String? retypePasswordErrorText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: BlocConsumer<SignUpBloc, SignUpState>(
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
                        _emaiLabel(),
                        _inputEmail(context),
                        _passWordLabel(),
                        _inputPassword(context),
                        _retypedPassWordLabel(),
                        _inputRetypedPassWord(),
                        _forgotPasswordLabel(),
                        _signUpButton(context),
                        _orContinueLabel(),
                        _socialLoginButtons(),
                        _backLogin(context),
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

  void handleState(BuildContext context, SignUpState state) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    switch (state.runtimeType) {
      case EmailInvalid:
        emailErrorText = (state as EmailInvalid).error;
        break;
      case EmailValid:
        emailErrorText = null;
        break;
      case PasswordInvalid:
        passwordErrorText = (state as PasswordInvalid).error;
        break;
      case PasswordValid:
        passwordErrorText = null;
        break;
      case PasswordsDoNotMatch:
        retypePasswordErrorText = (state as PasswordsDoNotMatch).error;
        break;
      case SignUpLoading:
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Signing up...'),
          ),
        );
        break;
      case SignUpSuccess:
        scaffoldMessenger.hideCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Sign up success!'),
          ),
        );
        Routes.navigateToReplacement(context, Routes.signInScreen);
        break;
      case SignUpFailure:
        scaffoldMessenger.hideCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text((state as SignUpFailure).error),
          ),
        );
        break;
    }
  }

  Row _backLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            )),
        TextButton(
          onPressed: () {
            Routes.navigateToReplacement(context, Routes.signInScreen);
          },
          child: const Text('Log in',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              )),
        ),
      ],
    );
  }

  Row _socialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/facebook-logo.svg',
            width: 50,
            height: 50,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/google-logo.svg',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }

  Container _orContinueLabel() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      child: const Text(
        'Or continue with',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  MyElevatedButton _signUpButton(BuildContext context) {
    return MyElevatedButton(
      text: 'Sign Up',
      height: 52,
      radius: 8,
      onPressed: () {
        context.read<SignUpBloc>().add(
              SignUpSubmitted(
                email: _emailController.text,
                password: _passwordController.text,
                retypePassword: _retypePasswordController.text,
              ),
            );
      },
    );
  }

  TextButton _forgotPasswordLabel() {
    return TextButton(
      onPressed: () {
        Routes.navigateTo(context, Routes.forgotPasswordScreen);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(top: 20, bottom: 15),
      ),
      child: const Text(
        'Forgot Password?',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
    );
  }

  TextField _inputPassword(BuildContext context) {
    return TextField(
      onChanged: (value) =>
          context.read<SignUpBloc>().add(PasswordChanged(password: value)),
      controller: _passwordController,
      decoration: InputDecoration(
        errorText: passwordErrorText,
        prefixIcon: const Icon(Icons.lock, size: 26, color: Color(0xFF0058C6)),
        hintText: '*****',
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Container _passWordLabel() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: const Text(
        'Password',
        style: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(164, 176, 190, 1),
        ),
      ),
    );
  }

  TextField _inputEmail(BuildContext context) {
    return TextField(
      controller: _emailController,
      onChanged: (value) =>
          context.read<SignUpBloc>().add(EmailChanged(email: value)),
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

  Container _emaiLabel() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: const Text(
        'Email',
        style: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(164, 176, 190, 1),
        ),
      ),
    );
  }

  _retypedPassWordLabel() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: const Text(
        'Retype Password',
        style: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(164, 176, 190, 1),
        ),
      ),
    );
  }

  _inputRetypedPassWord() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: _retypePasswordController,
        decoration: InputDecoration(
          errorText: retypePasswordErrorText,
          prefixIcon:
              const Icon(Icons.lock, size: 26, color: Color(0xFF0058C6)),
          hintText: '*****',
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
    );
  }
}
