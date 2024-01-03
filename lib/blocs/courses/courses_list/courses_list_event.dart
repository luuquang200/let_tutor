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
