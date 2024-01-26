import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/course/course_category.dart';

abstract class EbooksState extends Equatable {
  const EbooksState();

  @override
  List<Object> get props => [];
}

// Ebooks list
class EbooksListInitial extends EbooksState {}

class EbooksListLoading extends EbooksState {}

class EbooksListLoadSuccess extends EbooksState {
  final List<Course> ebooks;
  final List<CourseCategory> categories;
  final Map<String, dynamic> filters;

  const EbooksListLoadSuccess(this.ebooks, this.categories, this.filters);

  @override
  List<Object> get props => [ebooks, categories];

  EbooksListLoadSuccess copyWith(
      {List<Course>? ebooks,
      List<CourseCategory>? categories,
      Map<String, dynamic>? filters}) {
    return EbooksListLoadSuccess(
        ebooks ?? this.ebooks, categories ?? this.categories, filters ?? {});
  }
}

class EbooksListLoadFailure extends EbooksState {
  final String message;

  const EbooksListLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

// Course detail
class CourseDetailInitial extends EbooksState {
  const CourseDetailInitial();

  @override
  List<Object> get props => [];
}

class CourseDetailLoadSuccess extends EbooksState {
  final Course course;

  const CourseDetailLoadSuccess(this.course);

  @override
  List<Object> get props => [course];
}

class CourseDetailLoadFailure extends EbooksState {
  final String message;

  const CourseDetailLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class CourseDetailLoading extends EbooksState {
  const CourseDetailLoading();

  @override
  List<Object> get props => [];
}
