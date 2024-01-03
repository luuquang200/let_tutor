import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/course/course.dart';

abstract class CoursesListState extends Equatable {
  const CoursesListState();

  @override
  List<Object> get props => [];
}

class CoursesListInitial extends CoursesListState {}

class CoursesListLoading extends CoursesListState {}

class CoursesListLoadSuccess extends CoursesListState {
  final List<Course> courses;

  const CoursesListLoadSuccess(this.courses);

  @override
  List<Object> get props => [courses];

  CoursesListLoadSuccess copyWith({List<Course>? courses}) {
    return CoursesListLoadSuccess(courses ?? this.courses);
  }
}

class CoursesListLoadFailure extends CoursesListState {
  final String message;

  const CoursesListLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
