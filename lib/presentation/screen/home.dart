import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/screen/account_screen.dart';
import 'package:let_tutor/presentation/screen/courses_screen.dart';
import 'package:let_tutor/presentation/screen/schedule_screen.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/screen/tutor_list_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screens = [
    const TutorListScreen(),
    const ScheduleSceen(),
    const CoursesScreen(),
    const AccountScreen(),
  ];
  List<String> screenTitle = ['Tutors', 'Schedule', 'Courses', 'Account'];
  int selectedScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF0058C6)),
        title: Text(
          screenTitle[selectedScreenIndex],
          style: CustomTextStyle.topHeadline,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_outlined),
            onPressed: () {},
          ),
          SizedBox(width: 16)
        ],
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
}
