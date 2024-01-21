import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_event.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_state.dart';
import 'package:let_tutor/data/models/course/course_category.dart';
import 'package:let_tutor/data/repositories/course_repository.dart';
import 'package:let_tutor/presentation/screen/courses/course_detail.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/categories_filter.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/course_card.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/level_filter.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/loading_indicator.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/filter_bar.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/sort_selection.dart';

class AllCoursesTab extends StatefulWidget {
  const AllCoursesTab({super.key});

  @override
  State<AllCoursesTab> createState() => _AllCoursesTabState();
}

class _AllCoursesTabState extends State<AllCoursesTab> {
  bool visibilityFilter = false;
  List<CourseCategory> categories = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          FilterBar(
            onFilterPressed: () {
              setState(() {
                visibilityFilter = !visibilityFilter;
              });
            },
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: visibilityFilter,
            child: const Column(
              children: [
                LevelFilter(),
                SizedBox(
                  height: 8,
                ),
                CategoriesFilter(),
                SizedBox(
                  height: 8,
                ),
                SortSelection(),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CoursesListBloc, CourseState>(
              builder: (context, state) {
                if (state is CoursesListInitial) {
                  return const LoadingIndicator();
                } else if (state is CoursesListLoading) {
                  return const LoadingIndicator();
                } else if (state is CoursesListLoadFailure) {
                  return const Center(
                    child: Text('Error loading courses'),
                  );
                } else if (state is CoursesListLoadSuccess) {
                  return state.courses.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: state.courses.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => CoursesListBloc(
                                          courseRepository: CourseRepository())
                                        ..add(GetDetailCourse(
                                            state.courses[index].id ?? '')),
                                      child: CourseDetail(
                                          courseId:
                                              state.courses[index].id ?? ''),
                                    ),
                                  ),
                                );
                              },
                              child: CourseCard(
                                course: state.courses[index],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off_outlined, size: 64),
                              Text('No courses found'),
                            ],
                          ),
                        );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
