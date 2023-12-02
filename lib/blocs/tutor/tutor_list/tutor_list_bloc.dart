import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class TutorListBloc extends Bloc<TutorListEvent, TutorListState> {
  final TutorRepository tutorRepository;
  final page = 1;
  final tutorPerPage = 10;

  TutorListBloc({required this.tutorRepository}) : super(TutorListInitial()) {
    on<TutorListRequested>(_onTutorListRequested);
    on<FilterTutorsBySpeciality>(_onFilterTutorsBySpeciality);
  }

  void _onTutorListRequested(
      TutorListRequested event, Emitter<TutorListState> emit) async {
    emit(TutorListLoading());
    try {
      final tutors = await tutorRepository.getTutors();
      emit(TutorListSuccess(tutors));
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }

  void _onFilterTutorsBySpeciality(
      FilterTutorsBySpeciality event, Emitter<TutorListState> emit) async {
    emit(TutorListLoading());
    try {
      final filteredTutors = await tutorRepository.getTutorsBySpeciality(
          event.speciality, page, tutorPerPage);
      emit(TutorListSuccess(filteredTutors));
    } catch (error) {
      emit(TutorListFailure(error.toString()));
    }
  }
}
