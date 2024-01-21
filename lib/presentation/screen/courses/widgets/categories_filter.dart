import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_event.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_state.dart';
import 'package:let_tutor/data/models/course/course_category.dart';

class CategoriesFilter extends StatefulWidget {
  const CategoriesFilter({super.key});
  static String? _selectedCategory;
  @override
  State<CategoriesFilter> createState() => _CategoriesFilterState();
}

class _CategoriesFilterState extends State<CategoriesFilter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<CoursesListBloc>(context),
        buildWhen: (previous, current) {
          // build when the first time
          if (previous is CoursesListInitial) {
            return true;
          }
          // build when the categories list is changed
          if (previous is CoursesListLoadSuccess &&
              current is CoursesListLoadSuccess) {
            return previous.categories != current.categories;
          }
          return false;
        },
        builder: (context, state) {
          if (state is CoursesListLoadSuccess) {
            List<CourseCategory> categories = state.categories;
            ensureAllCategory(categories);
            setDefaultSelectedCategory(categories);
            return DropdownButton<String>(
              isExpanded: true,
              value: CategoriesFilter._selectedCategory,
              items: List.generate(
                categories.length,
                (index) => DropdownMenuItem(
                  value: categories[index].id.toString(),
                  child: Text(
                    categories[index].title ?? '',
                  ),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  CategoriesFilter._selectedCategory = value;
                });

                log('selected category: $value');

                context.read<CoursesListBloc>().add(GetCoursesListByCategory(
                      value!,
                    ));
              },
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        });
  }

  void ensureAllCategory(List<CourseCategory> categories) {
    if (!categories.any((category) => category.key == 'all')) {
      categories.insert(
          0, CourseCategory(title: 'All categories', key: 'all', id: '0'));
    }
  }

  void setDefaultSelectedCategory(List<CourseCategory> categories) {
    if (CategoriesFilter._selectedCategory == null) {
      log('setDefaultSelectedCategoryIfNull: ${categories[0].id}');
      CategoriesFilter._selectedCategory = categories[0].id;
    }
  }
}
