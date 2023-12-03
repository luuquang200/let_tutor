import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_state.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class TutorDetailBloc extends Bloc<TutorDetailEvent, TutorDetailState> {
  final TutorRepository tutorRepository;

  TutorDetailBloc({required this.tutorRepository})
      : super(TutorDetailInitial()) {
    on<TutorDetailRequested>(_onTutorDetailRequested);
  }

  FutureOr<void> _onTutorDetailRequested(
      TutorDetailRequested event, Emitter<TutorDetailState> emit) async {
    emit(TutorDetailLoading());
    try {
      final tutor = await tutorRepository.getTutorById(event.tutorId);

      emit(TutorDetailSuccess(tutor));
    } catch (error) {
      emit(TutorDetailFailure(error.toString()));
    }
  }
}
