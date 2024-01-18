import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/course_cover_image.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  static const Map<String, String> levels = {
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
                  Text(course.name ?? 'Course name',
                      style: CustomTextStyle.headlineLarge),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    course.description ?? 'Course description',
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
                        style: TextStyle(fontSize: 18),
                      )),
                      // length of the course
                      Text(
                        '${course.topics?.length.toString() ?? '0'} lessons',
                        style: TextStyle(fontSize: 18),
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
