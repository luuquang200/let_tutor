import 'package:equatable/equatable.dart';

abstract class CoursesListEvent extends Equatable {
  const CoursesListEvent();

  @override
  List<Object> get props => [];
}

class GetCoursesList extends CoursesListEvent {
  const GetCoursesList();

  @override
  List<Object> get props => [];
}

class GetDetailCourse extends CoursesListEvent {
  final String id;

  const GetDetailCourse(this.id);

  @override
  List<Object> get props => [id];
}
