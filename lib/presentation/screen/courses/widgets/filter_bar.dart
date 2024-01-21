import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_event.dart';

class FilterBar extends StatelessWidget {
  final VoidCallback onFilterPressed;
  static TextEditingController searchController = TextEditingController();
  const FilterBar({Key? key, required this.onFilterPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
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
            onSubmitted: (value) {
              context
                  .read<CoursesListBloc>()
                  .add(GetCoursesListBySearch(value));
            },
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        IconButton(
          icon: const Icon(Icons.filter_list_outlined),
          onPressed: onFilterPressed,
        ),
      ],
    );
  }
}
