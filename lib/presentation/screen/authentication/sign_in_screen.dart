import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/blocs/sign_in/sign_in_bloc.dart';
import 'package:let_tutor/blocs/sign_in/sign_in_event.dart';
import 'package:let_tutor/blocs/sign_in/sign_in_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is EmailInvalid) {
            emailErrorText = state.error;
          } else if (state is EmailValid) {
            emailErrorText = null;
          } else if (state is PasswordInvalid) {
            passwordErrorText = state.error;
          } else if (state is PasswordValid) {
            passwordErrorText = null;
          } else if (state is SignInLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Signing in...'),
              ),
            );
          } else if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Routes.navigateToReplacement(context, Routes.home);
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100, bottom: 30),
                    child: SvgPicture.asset(
                      'assets/lettutor_logo.svg',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(164, 176, 190, 1),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _emailController,
                          onChanged: (value) => context
                              .read<SignInBloc>()
                              .add(EmailChanged(email: value)),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail,
                                size: 26, color: Color(0xFF0058C6)),
                            hintText: 'mail@example.com',
                            hintStyle: const TextStyle(
                              color: Color(0xFFB0B0B0),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB0B0B0)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            errorText: emailErrorText,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          child: const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(164, 176, 190, 1),
                            ),
                          ),
                        ),
                        TextField(
                          onChanged: (value) => context
                              .read<SignInBloc>()
                              .add(PasswordChanged(password: value)),
                          controller: _passwordController,
                          decoration: InputDecoration(
                            errorText: passwordErrorText,
                            prefixIcon: const Icon(Icons.lock,
                                size: 26, color: Color(0xFF0058C6)),
                            hintText: '*****',
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(top: 20, bottom: 15),
                          ),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ),
                        MyElevatedButton(
                          text: 'Login',
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
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 30, bottom: 10),
                          child: const Text(
                            'Or continue with',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
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
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Not a member yet?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                )),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Sign Up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ),
                          ],
                        ),
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
}
