import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/repositories/course_repository.dart';
import 'courses_list_event.dart';
import 'courses_list_state.dart';

class CoursesListBloc extends Bloc<CoursesListEvent, CoursesListState> {
  final CourseRepository courseRepository;
  final perPage = 20;

  CoursesListBloc({required this.courseRepository})
      : super(CoursesListInitial()) {
    on<GetCoursesList>(_onGetCoursesList);
  }

  Future<void> _onGetCoursesList(
      GetCoursesList event, Emitter<CoursesListState> emit) async {
    emit(CoursesListLoading());
    try {
      List<Course> courses = await courseRepository.getCoursesList();
      emit(CoursesListLoadSuccess(courses));
    } catch (e) {
      emit(CoursesListLoadFailure(e.toString()));
    }
  }
}
