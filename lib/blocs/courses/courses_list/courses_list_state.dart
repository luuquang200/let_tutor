import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/course/course_category.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

// Courses list
class CoursesListInitial extends CourseState {}

class CoursesListLoading extends CourseState {}

class CoursesListLoadSuccess extends CourseState {
  final List<Course> courses;
  final List<CourseCategory> categories;
  final Map<String, dynamic> filters;
  final int totalPage;
  final int page;

  const CoursesListLoadSuccess(
      this.courses, this.categories, this.filters, this.totalPage, this.page);

  @override
  List<Object> get props => [courses, categories];

  CoursesListLoadSuccess copyWith(
      {List<Course>? courses,
      List<CourseCategory>? categories,
      Map<String, dynamic>? filters,
      int? totalPage,
      int? page}) {
    return CoursesListLoadSuccess(
        courses ?? this.courses,
        categories ?? this.categories,
        filters ?? {},
        totalPage ?? this.totalPage,
        page ?? this.page);
  }
}

class CoursesListLoadFailure extends CourseState {
  final String message;

  const CoursesListLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

// Course detail
class CourseDetailInitial extends CourseState {
  const CourseDetailInitial();

  @override
  List<Object> get props => [];
}

class CourseDetailLoadSuccess extends CourseState {
  final Course course;

  const CourseDetailLoadSuccess(this.course);

  @override
  List<Object> get props => [course];
}

class CourseDetailLoadFailure extends CourseState {
  final String message;

  const CourseDetailLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class CourseDetailLoading extends CourseState {
  const CourseDetailLoading();

  @override
  List<Object> get props => [];
}
