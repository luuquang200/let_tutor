import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_event.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_state.dart';

class LevelFilter extends StatelessWidget {
  const LevelFilter({super.key});

  static String? selectedLevel;
  static const List<String> levels = [
    'Any level',
    'Beginner',
    'Upper-Beginner',
    'Pre-Intermediate',
    'Intermediate',
    'Upper-Intermediate',
    'Pre-Advanced',
    'Advanced',
    'Very Advanced'
  ];

  @override
  Widget build(BuildContext context) {
    selectedLevel ??= levels[0];
    return BlocBuilder<CoursesListBloc, CourseState>(
      builder: (context, state) {
        return DropdownButton<String>(
          isExpanded: true,
          value: selectedLevel,
          items: levels.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (String? value) {
            selectedLevel = value;
            context.read<CoursesListBloc>().add(GetCoursesListByLevel(
                  levels.indexOf(value!).toString(),
                ));
          },
        );
      },
    );
  }
}
