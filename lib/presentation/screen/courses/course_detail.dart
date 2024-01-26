import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_state.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/course_cover_image.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/styles/theme.dart';
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
              title: Text('course_detail'.tr(),
                  style: CustomTextStyle.topHeadline),
              iconTheme: IconThemeData(color: AppTheme.primaryColor),
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
                      _dicoveryButton(course),
                      const SizedBox(height: 12),
                      _sectionTitle(context, 'overview'.tr()),
                      _courseOverview(course),
                      const SizedBox(height: 12),
                      _sectionTitle(context, 'experience_level'.tr()),
                      _expereinceLevel(course),
                      const SizedBox(height: 12),
                      _sectionTitle(context, 'course_length'.tr()),
                      _courseLength(course),
                      const SizedBox(height: 12),
                      _sectionTitle(context, 'list_of_topics'.tr()),
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
            body: Center(child: Text('failed_to_load_course_detail'.tr())),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  _dicoveryButton(Course course) {
    return MyElevatedButton(
      text: 'discover'.tr(),
      height: 50,
      radius: 8,
      onPressed: () {
        Navigator.pushNamed(context, Routes.topicDetail,
            arguments: course.topics?[0]);
      },
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
        Row(
          children: [
            const Icon(Icons.help_outline, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              'why_take_this_course'.tr(),
              style: CustomTextStyle.headlineMedium,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 16),
          child: Text(course.reason ?? ''),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.help_outline, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              'what_will_you_be_able_to_do'.tr(),
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
      '0': 'any_level'.tr(),
      '1': 'beginner'.tr(),
      '2': 'upper_beginner'.tr(),
      '3': 'pre_intermediate'.tr(),
      '4': 'intermediate'.tr(),
      '5': 'upper_intermediate'.tr(),
      '6': 'pre_advanced'.tr(),
      '7': 'advanced'.tr(),
      '8': 'very_advanced'.tr()
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
            Navigator.pushNamed(context, Routes.topicDetail,
                arguments: course.topics?[index]);
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
        _sectionTitle(context, 'suggested_tutors'.tr()),
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
                    child: Text('more_info'.tr()),
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
