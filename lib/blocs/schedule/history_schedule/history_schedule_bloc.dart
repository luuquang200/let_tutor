import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/schedule/history_schedule/history_schedule_event.dart';
import 'package:let_tutor/blocs/schedule/history_schedule/history_schedule_state.dart';
import 'package:let_tutor/data/models/schedule/schedule_response.dart';
import 'package:let_tutor/data/repositories/schedule_repository.dart';

class HistoryScheduleBloc
    extends Bloc<HistoryScheduleEvent, HistoryScheduleState> {
  final ScheduleRepository scheduleRepository;
  final perPage = 20;

  HistoryScheduleBloc({required this.scheduleRepository})
      : super(HistoryScheduleInitial()) {
    on<GetHistoryScheduleList>(_onGetHistoryScheduleList);
  }

  Future<void> _onGetHistoryScheduleList(
      GetHistoryScheduleList event, Emitter<HistoryScheduleState> emit) async {
    emit(HistoryScheduleLoading());
    try {
      ScheduleResponse scheduleResponse =
          await scheduleRepository.getHistoryScheduleList(page: event.page);
      log('length: ${scheduleResponse.rows.length}');
      int totalPage = (scheduleResponse.count / perPage).ceil();

      emit(HistoryScheduleLoadSuccess(
          scheduleResponse.rows, totalPage, event.page));
    } catch (e) {
      emit(HistoryScheduleLoadFailure(e.toString()));
    }
  }
}
