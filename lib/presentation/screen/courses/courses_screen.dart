import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_bloc.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_event.dart';
import 'package:let_tutor/blocs/courses/courses_list/courses_list_state.dart';
import 'package:let_tutor/blocs/courses/ebooks_list/ebooks_list_bloc.dart';
import 'package:let_tutor/blocs/courses/ebooks_list/ebooks_list_event.dart';
import 'package:let_tutor/data/repositories/course_repository.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/all_courses_tab.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/course_card.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/ebooks_tab.dart';
import 'package:let_tutor/presentation/styles/theme.dart';
import 'package:let_tutor/routes.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  bool visibilityFilter = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CoursesListBloc>(
            create: (context) => CoursesListBloc(
              courseRepository: CourseRepository(),
            )..add(const GetCoursesList(1)),
          ),
          BlocProvider<EbooksListBloc>(
            create: (context) => EbooksListBloc(
              courseRepository: CourseRepository(),
            )..add(const GetEbooksList()),
          ),
        ],
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(tabs: [
                _allCoursesTabHeadline(),
                _ebooksTabHeadline(),
              ]),
              const Expanded(
                child: TabBarView(children: [AllCoursesTab(), EbooksTab()]),
              )
            ],
          ),
        ));
  }

  _allCoursesTabHeadline() {
    return Tab(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book_outlined, color: AppTheme.primaryColor),
          const SizedBox(width: 8),
          Text(
            'all_courses'.tr(),
            style: TextStyle(color: AppTheme.primaryColor),
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
          Icon(Icons.phone_android_outlined, color: AppTheme.primaryColor),
          const SizedBox(width: 8),
          Text(
            'ebooks'.tr(),
            style: TextStyle(color: AppTheme.primaryColor),
          )
        ],
      ),
    );
  }
}
