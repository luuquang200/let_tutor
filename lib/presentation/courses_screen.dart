import 'package:flutter/material.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
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
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 24),
              hintStyle: TextStyle(color: Colors.grey[400]),
              hintText: 'search courses',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text('Courses'),
          )
        ],
      ),
    );
  }

  _ebooksTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 24),
              hintStyle: TextStyle(color: Colors.grey[400]),
              hintText: 'search e-books',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          Expanded(
            child: Text('Ebooks'),
          ),
        ],
      ),
    );
  }
}
