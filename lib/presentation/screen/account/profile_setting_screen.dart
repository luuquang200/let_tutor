import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_bloc.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_event.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_state.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';
import 'package:let_tutor/data/repositories/user_repository.dart';
import 'package:let_tutor/presentation/screen/account/widgets/information_setting.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/styles/theme.dart';
import 'package:let_tutor/presentation/widgets/custom_snack_bar.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';
import 'package:provider/provider.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);
    return BlocProvider(
      create: (context) => ProfileSettingBloc(
        userRepository: UserRepository(),
        tutorRepository: TutorRepository(),
      )..add(const GetProfileSettingPage()),
      child: BlocConsumer<ProfileSettingBloc, ProfileSettingState>(
        listener: (context, state) {
          if (state is ProfileSettingLoadSuccess) {
            if (state.isInvalidChange) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  icon: Icons.error,
                  backgroundColor: Colors.red,
                ),
              );
            }

            user = state.user;
            if (state.isUpdatedSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: 'Updated successfully',
                  icon: Icons.check,
                  backgroundColor: Colors.green,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is ProfileSettingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileSettingLoadSuccess) {
            user = state.user;
            return Scaffold(
              appBar: AppBar(
                title: Text('profile'.tr(), style: CustomTextStyle.topHeadline),
                iconTheme: AppTheme.iconTheme,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  children: [
                    _avatar(user, context),
                    const SizedBox(height: 16),
                    InformationSetting()
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
      child: Container(
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 201, 198, 198), // Color of padding
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: <Widget>[
            TutorAvatar(
              imageUrl: user.avatar ?? '',
              tutorName: user.name ?? '',
              radius: 98,
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                width: 44,
                height: 41,
                padding: const EdgeInsets.all(1.0), // Adjust padding here
                decoration: const BoxDecoration(
                  color: Color(0xFF0058C6),
                  shape: BoxShape.circle, // Circular shape
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.white,
                  onPressed: () async {
                    // choose image to change avatar
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      BlocProvider.of<ProfileSettingBloc>(context).add(
                        ChangeAvatar(
                          avatarUrl: pickedFile.path,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
