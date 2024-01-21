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

class GetCoursesListByCategory extends CoursesListEvent {
  final String category;

  const GetCoursesListByCategory(this.category);

  @override
  List<Object> get props => [category];
}

class GetCoursesListByLevel extends CoursesListEvent {
  final String level;

  const GetCoursesListByLevel(this.level);

  @override
  List<Object> get props => [level];
}

class GetCoursesListBySortLevel extends CoursesListEvent {
  final String sortLevel;

  const GetCoursesListBySortLevel(this.sortLevel);

  @override
  List<Object> get props => [sortLevel];
}

class GetCoursesListBySearch extends CoursesListEvent {
  final String search;

  const GetCoursesListBySearch(this.search);

  @override
  List<Object> get props => [search];
}
