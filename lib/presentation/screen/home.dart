import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/screen/account/account_screen.dart';
import 'package:let_tutor/presentation/screen/courses/courses_screen.dart';
import 'package:let_tutor/presentation/screen/schedule/schedule_screen.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_list/tutor_list_screen.dart';
import 'package:let_tutor/routes.dart';

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
  List<String> screenTitle = ['Tutors', 'Schedule', 'Courses', 'Account'];
  int selectedScreenIndex = 0;
  int currentIndex = 0;
  List<String> listNationalities = <String>['Vietnamese', 'English'];

  late String currentLanguage = listNationalities[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF0058C6)),
        title: Text(
          screenTitle[selectedScreenIndex],
          style: CustomTextStyle.topHeadline,
        ),
        actions: [_selectLanguage(context), const SizedBox(width: 16)],
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Tutors'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit_calendar_outlined), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Account'),
        ],
      ),
    );
  }

  _selectLanguage(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 223, 228, 249),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: SvgPicture.asset(
              'assets/flags/$currentLanguage.svg',
              width: 24,
              height: 24,
            ),
          )),
      onSelected: (String value) {
        setState(() {
          currentLanguage = value;
          context.setLocale(value == 'English'
              ? const Locale('en', 'US')
              : const Locale('vi', 'VN'));
        });
      },
      itemBuilder: (BuildContext context) {
        return listNationalities.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Row(
              children: <Widget>[
                const SizedBox(width: 10),
                SvgPicture.asset(
                  'assets/flags/$value.svg',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 10),
                Text(value),
              ],
            ),
          );
        }).toList();
      },
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
