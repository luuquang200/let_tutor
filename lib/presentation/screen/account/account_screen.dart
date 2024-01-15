import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:let_tutor/blocs/account/account_home/account_bloc.dart';
import 'package:let_tutor/blocs/account/account_home/account_event.dart';
import 'package:let_tutor/blocs/account/account_home/account_state.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/repositories/user_repository.dart';
import 'package:let_tutor/presentation/screen/account/widgets/item_card.dart';
import 'package:let_tutor/presentation/screen/account/widgets/item_list.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';
import 'package:let_tutor/routes.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(
        userRepository: UserRepository(),
      )..add(const GetAccountPage()),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AccountLoadSuccess) {
            User user = state.user;
            return Scaffold(
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    _avatar(user, context),
                    const SizedBox(height: 16),
                    _name(user),
                    const SizedBox(height: 32),
                    ItemList(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Failed to load account information'),
            );
          }
        },
      ),
    );
  }

  _avatar(User user, BuildContext context) {
    return Center(
      child: TutorAvatar(
        imageUrl: user.avatar ?? '',
        tutorName: user.name ?? '',
        radius: 98,
      ),
    );
  }

  _name(User user) {
    return Text(
      user.name ?? '',
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }
}
