import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:let_tutor/data/models/tutor.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class TutorListBloc extends Bloc<TutorListEvent, TutorListState> {
  final TutorRepository tutorRepository;

  TutorListBloc({required this.tutorRepository}) : super(TutorListInitial()) {
    on<TutorListRequested>(_onTutorListRequested);
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
}
