import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/widgets/course_card.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
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
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              _allCoursesTabHeadline(),
              _ebooksTabHeadline(),
            ]),
            Expanded(
              child: TabBarView(children: [_allCoursesTab(), _ebooksTab()]),
            )
          ],
        ));
  }

  _allCoursesTabHeadline() {
    return Tab(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            'All Courses',
            style: TextStyle(color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }

  _ebooksTabHeadline() {
    return Tab(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.phone_android_outlined,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            'E-Books',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }

  _allCoursesTab() {
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
                _levelFilter(),
                const SizedBox(
                  height: 8,
                ),
                _categoriesFilter(),
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
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CourseCard());
              },
            ),
          ),
        ],
      ),
    );
  }

  _ebooksTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _filterBar(),
          const SizedBox(height: 8),
          Visibility(
            visible: visibilityFilter,
            child: Column(
              children: [
                _levelFilter(),
                const SizedBox(
                  height: 8,
                ),
                _categoriesFilter(),
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
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: CourseCard(),
                );
              },
            ),
          ),
        ],
      ),
    );
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
