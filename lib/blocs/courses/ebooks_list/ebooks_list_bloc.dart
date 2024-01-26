import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/ebooks_list/ebooks_list_event.dart';
import 'package:let_tutor/blocs/courses/ebooks_list/ebooks_list_state.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/course/course_category.dart';
import 'package:let_tutor/data/repositories/course_repository.dart';

class EbooksListBloc extends Bloc<EbooksListEvent, EbooksState> {
  final CourseRepository courseRepository;
  final page = 1;
  final size = 100;
  final perPage = 20;

  EbooksListBloc({required this.courseRepository})
      : super(EbooksListInitial()) {
    on<GetEbooksList>(_onGetEbooksList);
  }

  Future<void> _onGetEbooksList(
      GetEbooksList event, Emitter<EbooksState> emit) async {
    emit(EbooksListLoading());
    try {
      List<Course> ebooks = await courseRepository
          .searchEbooks(page: 1, size: 10, perPage: perPage, map: {});
      List<CourseCategory> categories =
          await courseRepository.getCourseCategories();

      emit(EbooksListLoadSuccess(ebooks, categories, const {}));
    } catch (e) {
      emit(EbooksListLoadFailure(e.toString()));
    }
  }
}
