import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_state.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/course_card.dart';
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
  List<String> categories = [
    'All categories',
    'For Studying Abroad',
    'English For Traveling',
    'Conversational English',
    'English For Beginners',
    'Business English',
    'English For Kids',
    'STARTERS',
    'PET',
    'KET',
    'MOVERS',
    'FLYERS',
    'TOEFL',
    'TOEIC',
    'IELTS'
  ];
  List<String> sortLevels = [
    'Sort by level',
    'Level decreasing',
    'Level increasing'
  ];
  late String _selectedLevel = levels[0];
  late String _selectedCategory = categories[0];
  late String _selectedSortLevel = sortLevels[0];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<CoursesListBloc>(context),
        builder: (context, state) {
          if (state is CoursesListLoading) {
            return const Center(
              widthFactor: 1,
              child: CircularProgressIndicator(),
            );
          } else if (state is CoursesListLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.courses.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.courseDetail,
                        arguments: state.courses[index],
                      );
                    },
                    child: CourseCard(
                      course: state.courses[index],
                    ),
                  );
                },
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

  _categoriesFilter() {
    return DropdownButton<String>(
      isExpanded: true,
      value: _selectedCategory,
      items: List.generate(
        categories.length,
        (index) => DropdownMenuItem(
          value: categories[index],
          child: Text(
            categories[index],
          ),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value!;
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
