import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/course_cover_image.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  static final Map<String, String> levels = {
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

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        surfaceTintColor: Colors.white,
        child: Column(
          children: [
            CourseCoverImage(imageUrl: course.imageUrl ?? ''),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.name ?? '', style: CustomTextStyle.headlineLarge),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    course.description ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        levels[course.level] ?? '',
                        style: const TextStyle(fontSize: 18),
                      )),
                      // length of the course
                      Text(
                        '${course.topics?.length.toString() ?? '0'} ${'lesson'.tr()}',
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
