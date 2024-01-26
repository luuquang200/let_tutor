import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/course/course_category.dart';
import 'package:let_tutor/data/models/course/course_reponse.dart';
import 'package:let_tutor/data/repositories/course_repository.dart';
import 'courses_list_event.dart';
import 'courses_list_state.dart';

class CoursesListBloc extends Bloc<CoursesListEvent, CourseState> {
  final CourseRepository courseRepository;
  final page = 1;
  final size = 10;
  final perPage = 10;

  CoursesListBloc({required this.courseRepository})
      : super(CoursesListInitial()) {
    on<GetCoursesList>(_onGetCoursesList);
    on<GetDetailCourse>(_onGetDetailCourse);
    on<GetCoursesListByCategory>(_onGetCoursesListByCategory);
    on<GetCoursesListByLevel>(_onGetCoursesListByLevel);
    on<GetCoursesListBySortLevel>(_onGetCoursesListBySortLevel);
    on<GetCoursesListBySearch>(_onGetCoursesListBySearch);
  }

  Future<void> _onGetCoursesList(
      GetCoursesList event, Emitter<CourseState> emit) async {
    var currentState = state;
    Map<String, dynamic> filters = {};
    if (currentState is CoursesListLoadSuccess) {
      filters = Map<String, dynamic>.from(currentState.filters);
    }

    emit(CoursesListLoading());
    try {
      CourseResponse courseResponse = await courseRepository.searchCourses(
          page: event.page, size: size, map: filters);
      List<Course> courses = courseResponse.rows;
      int totalPage = (courseResponse.count / perPage).ceil();

      List<CourseCategory> categories =
          await courseRepository.getCourseCategories();

      emit(CoursesListLoadSuccess(
          courses, categories, const {}, totalPage, event.page));
    } catch (e) {
      emit(CoursesListLoadFailure(e.toString()));
    }
  }

  FutureOr<void> _onGetDetailCourse(
      GetDetailCourse event, Emitter<CourseState> emit) async {
    emit(const CourseDetailLoading());
    try {
      Course course = await courseRepository.getDetailCourse(event.id);
      log('called get detail course');
      emit(CourseDetailLoadSuccess(course));
    } catch (e) {
      emit(CourseDetailLoadFailure(e.toString()));
    }
  }

  // level
  FutureOr<void> _onGetCoursesListByLevel(
      GetCoursesListByLevel event, Emitter<CourseState> emit) async {
    var currentState = state;
    Map<String, dynamic> filters = {};
    if (currentState is CoursesListLoadSuccess) {
      filters = Map<String, dynamic>.from(currentState.filters);

      if (filters['level[]'] != '0') {
        filters['level[]'] = event.level;
      } else {
        filters.remove('level[]');
      }
    }
    log('filters: $filters');

    emit(CoursesListLoading());

    try {
      //page, size, perPage, filters
      CourseResponse courseResponse = await courseRepository.searchCourses(
          page: page, size: size, map: filters);

      List<Course> courses = courseResponse.rows;
      int totalPage = (courseResponse.count / perPage).ceil();

      List<CourseCategory> categories =
          await courseRepository.getCourseCategories();

      emit(CoursesListLoadSuccess(
        courses,
        categories,
        filters,
        totalPage,
        page,
      ));
    } catch (e) {
      emit(CoursesListLoadFailure(e.toString()));
    }
  }

  // category
  FutureOr<void> _onGetCoursesListByCategory(
      GetCoursesListByCategory event, Emitter<CourseState> emit) async {
    var currentState = state;
    Map<String, dynamic> filters = {};
    if (currentState is CoursesListLoadSuccess) {
      filters = Map<String, dynamic>.from(currentState.filters);

      if (filters['category[]'] == '0') {
        filters.remove('orderBy[]');
      } else {
        filters['category[]'] = event.category;
      }
    }
    log('filters: $filters');

    emit(CoursesListLoading());

    try {
      //page, size, perPage, filters
      CourseResponse courseResponse = await courseRepository.searchCourses(
          page: page, size: size, map: filters);

      List<Course> courses = courseResponse.rows;
      int totalPage = (courseResponse.count / perPage).ceil();

      List<CourseCategory> categories =
          await courseRepository.getCourseCategories();
      emit(CoursesListLoadSuccess(
          courses, categories, filters, totalPage, page));
    } catch (e) {
      emit(CoursesListLoadFailure(e.toString()));
    }
  }

  // sort level
  FutureOr<void> _onGetCoursesListBySortLevel(
      GetCoursesListBySortLevel event, Emitter<CourseState> emit) async {
    var currentState = state;
    Map<String, dynamic> filters = {};
    if (currentState is CoursesListLoadSuccess) {
      filters = Map<String, dynamic>.from(currentState.filters);
      if (event.sortLevel == '') {
        filters.remove('orderBy[]');
      } else {
        filters['orderBy[]'] = event.sortLevel;
      }
    }
    log('filters: $filters');

    emit(CoursesListLoading());

    try {
      //page, size, perPage, filters
      CourseResponse courseResponse = await courseRepository.searchCourses(
          page: page, size: size, map: filters);

      List<Course> courses = courseResponse.rows;
      int totalPage = (courseResponse.count / perPage).ceil();
      List<CourseCategory> categories =
          await courseRepository.getCourseCategories();
      emit(CoursesListLoadSuccess(
          courses, categories, filters, totalPage, page));
    } catch (e) {
      emit(CoursesListLoadFailure(e.toString()));
    }
  }

  // search
  FutureOr<void> _onGetCoursesListBySearch(
      GetCoursesListBySearch event, Emitter<CourseState> emit) async {
    var currentState = state;
    Map<String, dynamic> filters = {};
    if (currentState is CoursesListLoadSuccess) {
      filters = Map<String, dynamic>.from(currentState.filters);
      filters['q'] = event.search;
    }
    log('filters: $filters');

    emit(CoursesListLoading());

    try {
      CourseResponse courseResponse = await courseRepository.searchCourses(
          page: page, size: size, map: filters);

      List<Course> courses = courseResponse.rows;
      int totalPage = (courseResponse.count / perPage).ceil();

      List<CourseCategory> categories =
          await courseRepository.getCourseCategories();
      emit(CoursesListLoadSuccess(
          courses, categories, filters, totalPage, page));
    } catch (e) {
      emit(CoursesListLoadFailure(e.toString()));
    }
  }
}
