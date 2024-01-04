import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_state.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/course_cover_image.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/routes.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key, required this.courseId});
  final String courseId;

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  List<String> listOfTopics = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesListBloc, CourseState>(
      builder: (context, state) {
        if (state is CourseDetailLoadSuccess) {
          Course course = state.course;
          return Scaffold(
            appBar: AppBar(
              title: Text('Course Detail', style: CustomTextStyle.topHeadline),
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                // Course cover photo
                CourseCoverImage(imageUrl: course.imageUrl ?? ''),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      _introductionInfo(course),
                      const SizedBox(height: 12),
                      _dicoveryButton(),
                      const SizedBox(height: 12),
                      _sectionTitle(context, 'Overview'),
                      _courseOverview(course),
                      const SizedBox(height: 12),
                      _sectionTitle(context, 'Experience Level'),
                      _expereinceLevel(course),
                      const SizedBox(height: 12),
                      _sectionTitle(context, 'Course Length'),
                      _courseLength(course),
                      const SizedBox(height: 12),
                      _sectionTitle(context, 'List Of Topics'),
                      _topicsList(course),
                      _suggestTutors(course),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ]),
            ),
          );
        } else if (state is CourseDetailLoadFailure) {
          return Scaffold(
            body: Center(child: Text('Failed to load course detail')),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  _dicoveryButton() {
    return MyElevatedButton(
      text: 'Discover',
      height: 50,
      radius: 8,
      onPressed: () {},
    );
  }

  Widget _sectionTitle(BuildContext context, String sectionTitle) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
          child: Divider(height: 1, color: Color.fromARGB(255, 200, 197, 197)),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(sectionTitle, style: CustomTextStyle.headlineLarge),
        const SizedBox(
          width: 10,
        ),
        const Expanded(
          child: Divider(height: 1, color: Color.fromARGB(255, 200, 197, 197)),
        )
      ],
    );
  }

  _courseOverview(Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Row(
          children: [
            Icon(Icons.help_outline, color: Colors.red),
            SizedBox(width: 8),
            Text(
              'Why Take This Course?',
              style: CustomTextStyle.headlineMedium,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(left: 32, right: 16),
          child: Text(course.reason ?? ''),
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Icon(Icons.help_outline, color: Colors.red),
            SizedBox(width: 8),
            Text(
              'What will you be able to do?',
              style: CustomTextStyle.headlineMedium,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 16),
          child: Text(course.purpose ?? ''),
        ),
      ],
    );
  }

  _expereinceLevel(Course course) {
    Map<String, String> levels = {
      '0': 'Any Level',
      '1': 'Beginner',
      '2': 'Upper-Beginner',
      '3': 'Pre-Intermediate',
      '4': 'Intermediate',
      '5': 'Upper-Intermediate',
      '6': 'Pre-Advanced',
      '7': 'Advanced',
      '8': 'Very Advanced'
    };
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 12),
      Row(
        children: [
          const Icon(Icons.group_add_outlined, color: Color(0xFF0058C6)),
          const SizedBox(width: 8),
          Text(levels[course.level] ?? '',
              style: CustomTextStyle.headlineMedium),
        ],
      )
    ]);
  }

  _courseLength(Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.book_outlined, color: Color(0xFF0058C6)),
            const SizedBox(width: 8),
            Text(course.topics?.length.toString() ?? '0',
                style: CustomTextStyle.headlineMedium),
          ],
        )
      ],
    );
  }

  _topicsList(Course course) {
    listOfTopics = course.topics?.map((e) => e.name ?? '').toList() ?? [];
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listOfTopics.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Routes.navigateTo(context, Routes.topicDetail);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Card(
                elevation: 1.5,
                surfaceTintColor: Colors.white,
                child: ListTile(
                    title: Text('${index + 1}. ${listOfTopics[index]}'))),
          ),
        );
      },
    );
  }

  _suggestTutors(Course course) {
    if (course.users == null || course.users!.isEmpty) {
      return const SizedBox.shrink();
    }

    List<User> users = course.users ?? [];
    return Column(
      children: [
        _sectionTitle(context, 'Suggested Tutors'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(users[index].name ?? '',
                      style: CustomTextStyle.headlineMedium),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.tutorDetail,
                          arguments: users[index].id ?? '');
                    },
                    child: const Text('More Info'),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  _introductionInfo(Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(course.name ?? '', style: CustomTextStyle.titleLarge),
        const SizedBox(height: 12),
        Text(
          course.description ?? '',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
