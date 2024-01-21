import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_event.dart';

class SortSelection extends StatefulWidget {
  const SortSelection({super.key});
  static String? _selectedSort;
  @override
  State<SortSelection> createState() => _SortSelectionState();
}

class _SortSelectionState extends State<SortSelection> {
  static const Map<String, String> sortOptions = {
    'Sort by level': '',
    'Level decreasing': 'DESC',
    'Level increasing': 'ASC',
  };

  @override
  Widget build(BuildContext context) {
    SortSelection._selectedSort ??= sortOptions.values.first;
    return DropdownButton<String>(
      isExpanded: true,
      value: SortSelection._selectedSort,
      items: sortOptions.keys.map((String key) {
        return DropdownMenuItem<String>(
          value: sortOptions[key],
          child: Text(key),
        );
      }).toList(),
      onChanged: (value) {
        SortSelection._selectedSort = value!;
        context.read<CoursesListBloc>().add(GetCoursesListBySortLevel(
              value,
            ));
      },
    );
  }
}
