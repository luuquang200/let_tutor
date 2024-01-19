import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_event.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            context.read<SignInBloc>().add(SignInWithFacebook());
          },
          icon: SvgPicture.asset(
            'assets/facebook-logo.svg',
            width: 50,
            height: 50,
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<SignInBloc>().add(SignInWithGoogle());
          },
          icon: SvgPicture.asset(
            'assets/google-logo.svg',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}
