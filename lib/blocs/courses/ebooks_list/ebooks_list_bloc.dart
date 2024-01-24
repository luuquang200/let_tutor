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
    // on<GetDetailCourse>(_onGetDetailCourse);
    // on<GetEbooksListByCategory>(_onGetEbooksListByCategory);
    // on<GetEbooksListByLevel>(_onGetEbooksListByLevel);
    // on<GetEbooksListBySortLevel>(_onGetEbooksListBySortLevel);
    // on<GetEbooksListBySearch>(_onGetEbooksListBySearch);
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

  // FutureOr<void> _onGetDetailCourse(
  //     GetDetailCourse event, Emitter<EbooksState> emit) async {
  //   emit(const CourseDetailLoading());
  //   try {
  //     Course course = await courseRepository.getDetailCourse(event.id);
  //     log('called get detail course');
  //     emit(CourseDetailLoadSuccess(course));
  //   } catch (e) {
  //     emit(CourseDetailLoadFailure(e.toString()));
  //   }
  // }

  // // level
  // FutureOr<void> _onGetEbooksListByLevel(
  //     GetEbooksListByLevel event, Emitter<EbooksState> emit) async {
  //   var currentState = state;
  //   Map<String, dynamic> filters = {};
  //   if (currentState is EbooksListLoadSuccess) {
  //     filters = Map<String, dynamic>.from(currentState.filters);
  //     filters['level[]'] = event.level;
  //   }
  //   log('filters: $filters');

  //   emit(EbooksListLoading());

  //   try {
  //     //page, size, perPage, filters
  //     List<Course> Ebooks = await courseRepository.searchEbooks(
  //         page: page, size: size, perPage: perPage, map: filters);
  //     List<CourseCategory> categories =
  //         await courseRepository.getCourseCategories();
  //     emit(EbooksListLoadSuccess(Ebooks, categories, filters));
  //   } catch (e) {
  //     emit(EbooksListLoadFailure(e.toString()));
  //   }
  // }

  // // category
  // FutureOr<void> _onGetEbooksListByCategory(
  //     GetEbooksListByCategory event, Emitter<EbooksState> emit) async {
  //   var currentState = state;
  //   Map<String, dynamic> filters = {};
  //   if (currentState is EbooksListLoadSuccess) {
  //     filters = Map<String, dynamic>.from(currentState.filters);
  //     filters['category[]'] = event.category;
  //   }
  //   log('filters: $filters');

  //   emit(EbooksListLoading());

  //   try {
  //     //page, size, perPage, filters
  //     List<Course> Ebooks = await courseRepository.searchEbooks(
  //         page: page, size: size, perPage: perPage, map: filters);
  //     List<CourseCategory> categories =
  //         await courseRepository.getCourseCategories();
  //     emit(EbooksListLoadSuccess(Ebooks, categories, filters));
  //   } catch (e) {
  //     emit(EbooksListLoadFailure(e.toString()));
  //   }
  // }

  // // sort level
  // FutureOr<void> _onGetEbooksListBySortLevel(
  //     GetEbooksListBySortLevel event, Emitter<EbooksState> emit) async {
  //   var currentState = state;
  //   Map<String, dynamic> filters = {};
  //   if (currentState is EbooksListLoadSuccess) {
  //     filters = Map<String, dynamic>.from(currentState.filters);
  //     if (event.sortLevel == '') {
  //       filters.remove('orderBy[]');
  //     } else {
  //       filters['orderBy[]'] = event.sortLevel;
  //     }
  //   }
  //   log('filters: $filters');

  //   emit(EbooksListLoading());

  //   try {
  //     //page, size, perPage, filters
  //     List<Course> Ebooks = await courseRepository.searchEbooks(
  //         page: page, size: size, perPage: perPage, map: filters);
  //     List<CourseCategory> categories =
  //         await courseRepository.getCourseCategories();
  //     emit(EbooksListLoadSuccess(Ebooks, categories, filters));
  //   } catch (e) {
  //     emit(EbooksListLoadFailure(e.toString()));
  //   }
  // }

  // // search
  // FutureOr<void> _onGetEbooksListBySearch(
  //     GetEbooksListBySearch event, Emitter<EbooksState> emit) async {
  //   var currentState = state;
  //   Map<String, dynamic> filters = {};
  //   if (currentState is EbooksListLoadSuccess) {
  //     filters = Map<String, dynamic>.from(currentState.filters);
  //     filters['q'] = event.search;
  //   }
  //   log('filters: $filters');

  //   emit(EbooksListLoading());

  //   try {
  //     //page, size, perPage, filters
  //     List<Course> Ebooks = await courseRepository.searchEbooks(
  //         page: page, size: size, perPage: perPage, map: filters);
  //     List<CourseCategory> categories =
  //         await courseRepository.getCourseCategories();
  //     emit(EbooksListLoadSuccess(Ebooks, categories, filters));
  //   } catch (e) {
  //     emit(EbooksListLoadFailure(e.toString()));
  //   }
  // }
}
