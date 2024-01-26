import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/assets/assets_manager.dart';
import 'package:let_tutor/presentation/screen/account/account_screen.dart';
import 'package:let_tutor/presentation/screen/courses/courses_screen.dart';
import 'package:let_tutor/presentation/screen/schedule/schedule_screen.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_list/tutor_list_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screens = [
    const TutorListScreen(),
    const ScheduleScreen(),
    const CoursesScreen(),
    const AccountScreen(),
  ];
  List<String> get screenTitle =>
      ['tutors'.tr(), 'schedule'.tr(), 'courses'.tr(), 'account'.tr()];
  int selectedScreenIndex = 0;
  int currentIndex = 0;
  List<String> listNationalities = <String>['Vietnamese', 'English'];

  late String currentLanguage = listNationalities[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // iconTheme: Provider.of<AppTheme>(context).getIconTheme(),
        title: Text(
          screenTitle[selectedScreenIndex],
          style: CustomTextStyle.topHeadline,
        ),
        actions: [_displayLanguageIcon(context), const SizedBox(width: 16)],
      ),
      body: screens[selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            selectedScreenIndex = value;
          });
        },
        elevation: 20,
        currentIndex: selectedScreenIndex,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.people), label: 'tutors'.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.edit_calendar_outlined),
              label: 'schedule'.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.school), label: 'courses'.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              label: 'account'.tr()),
        ],
      ),
    );
  }

  Widget _displayLanguageIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 223, 228, 249),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: SvgPicture.asset(
          context.locale.languageCode == 'vi'
              ? AssetsManager.vietnameseFlag
              : AssetsManager.englishFlag,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
