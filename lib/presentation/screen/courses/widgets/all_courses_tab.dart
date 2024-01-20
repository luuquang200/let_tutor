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
import 'package:let_tutor/routes.dart';

class AllCoursesTab extends StatefulWidget {
  const AllCoursesTab({super.key});

  @override
  State<AllCoursesTab> createState() => _AllCoursesTabState();
}

class _AllCoursesTabState extends State<AllCoursesTab> {
  bool visibilityFilter = false;
  List<String> levels = [
    'All level',
    'Beginner',
    'Upper-Beginner',
    'Pre-Intermediate',
    'Intermediate',
    'Upper-Intermediate',
    'Pre-Advanced',
    'Advanced',
    'Very Advanced'
  ];
  List<CourseCategory> categories = [];
  List<String> sortLevels = [
    'Sort by level',
    'Level decreasing',
    'Level increasing'
  ];
  late String _selectedLevel = levels[0];
  late String _selectedSortLevel = sortLevels[0];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<CoursesListBloc>(context),
        builder: (context, state) {
          if (state is CoursesListLoading) {
            return const LoadingIndicator();
          } else if (state is CoursesListLoadSuccess) {
            categories = state.categories;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  _filterBar(),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: visibilityFilter,
                    child: Column(
                      children: [
                        const LevelFilter(),
                        const SizedBox(
                          height: 8,
                        ),
                        const CategoriesFilter(),
                        const SizedBox(
                          height: 8,
                        ),
                        _sortLevel(),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: state.courses.length > 0
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
                                            courseRepository:
                                                CourseRepository())
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
                          ),
                  ),
                ],
              ),
            );
          } else if (state is CoursesListLoadFailure) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        });
  }

  _filterBar() {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(right: 24),
              hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
              hintText: 'Enter a course name',
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xFFB0B0B0),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFB0B0B0), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        IconButton(
          icon: const Icon(Icons.filter_list_outlined),
          onPressed: () {
            setState(() {
              visibilityFilter = !visibilityFilter;
            });
          },
        ),
      ],
    );
  }

  Widget _levelFilter() {
    return DropdownButton<String>(
      isExpanded: true,
      value: _selectedLevel,
      items: List.generate(
        levels.length,
        (index) => DropdownMenuItem(
          value: levels[index],
          child: Text(
            levels[index],
          ),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _selectedLevel = value!;
        });
      },
    );
  }

  _sortLevel() {
    return DropdownButton<String>(
      isExpanded: true,
      value: _selectedSortLevel,
      items: List.generate(
        sortLevels.length,
        (index) => DropdownMenuItem(
          value: sortLevels[index],
          child: Text(
            sortLevels[index],
          ),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _selectedSortLevel = value!;
        });
      },
    );
  }
}