import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/course/course_category.dart';
import 'package:let_tutor/data/repositories/course_repository.dart';
import 'courses_list_event.dart';
import 'courses_list_state.dart';

class CoursesListBloc extends Bloc<CoursesListEvent, CourseState> {
  final CourseRepository courseRepository;
  final perPage = 20;

  CoursesListBloc({required this.courseRepository})
      : super(CoursesListInitial()) {
    on<GetCoursesList>(_onGetCoursesList);
    on<GetDetailCourse>(_onGetDetailCourse);
  }

  Future<void> _onGetCoursesList(
      GetCoursesList event, Emitter<CourseState> emit) async {
    emit(CoursesListLoading());
    try {
      List<Course> courses = await courseRepository.getCoursesList();
      List<CourseCategory> categories =
          await courseRepository.getCourseCategories();

      // log all name of categories
      for (var element in categories) {
        log(element.title ?? '');
      }
      emit(CoursesListLoadSuccess(courses, categories));
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
}
