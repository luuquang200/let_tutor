import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/schedule/schedule_event.dart';
import 'package:let_tutor/blocs/schedule/schedule_state.dart';
import 'package:let_tutor/data/models/schedule/booking.dart';
import 'package:let_tutor/data/repositories/schedule_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleBloc({required this.scheduleRepository}) : super(ScheduleInitial()) {
    on<GetScheduleList>(_onGetScheduleList);
    on<CancelSchedule>(_onCancelSchedule);
    on<UpdateRequest>(_onUpdateRequest);
  }

  Future<void> _onGetScheduleList(
      GetScheduleList event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());
    try {
      final schedules = await scheduleRepository.getScheduleList(page: 1);
      // sort by start time
      schedules.sort((a, b) => a.scheduleDetailInfo!.startPeriodTimestamp!
          .compareTo(b.scheduleDetailInfo!.startPeriodTimestamp!));

      // group by start time and teacher
      var groupedSchedules = <List<BookedSchedule>>[];
      for (final schedule in schedules) {
        for (final group in groupedSchedules) {
          if (isSameGroup(group.last, schedule)) {
            group.add(schedule);
            break;
          }
        }
        if (!groupedSchedules.any((group) => group.contains(schedule))) {
          groupedSchedules.add([schedule]);
        }
      }

      emit(ScheduleLoadSuccess(groupedSchedules));
    } catch (e) {
      emit(ScheduleLoadFailure(e.toString()));
    }
  }

  bool isSameGroup(
      BookedSchedule lastSchedule, BookedSchedule currentSchedule) {
    final endTime = DateTime.fromMillisecondsSinceEpoch(
        lastSchedule.scheduleDetailInfo?.endPeriodTimestamp ?? 0);
    final startTime = DateTime.fromMillisecondsSinceEpoch(
        currentSchedule.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
    final checkSameTeacher =
        lastSchedule.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name ==
            currentSchedule.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name;
    return startTime.difference(endTime).inMinutes <= 5 && checkSameTeacher;
  }

  Future<void> _onCancelSchedule(
      CancelSchedule event, Emitter<ScheduleState> emit) async {
    final ScheduleState currentState;
    if (state is! ScheduleLoadSuccess) {
      return;
    }
    currentState = state;

    emit(ScheduleLoading());
    try {
      await scheduleRepository.cancelSchedule(event.scheduleId);

      if (currentState is ScheduleLoadSuccess) {
        final schedules = currentState.schedules;
        for (var group in schedules) {
          group.removeWhere((schedule) => schedule.id == event.scheduleId);
        }

        emit(ScheduleLoadSuccess(schedules, isCancelSuccess: true));
      }
    } catch (e) {
      emit(ScheduleLoadFailure(e.toString()));
    }
  }

  FutureOr<void> _onUpdateRequest(
      UpdateRequest event, Emitter<ScheduleState> emit) async {
    final ScheduleState currentState;
    if (state is! ScheduleLoadSuccess) {
      return;
    }
    currentState = state;
    emit(ScheduleLoading());
    try {
      await scheduleRepository.updateRequest(event.scheduleId, event.request);

      if (currentState is ScheduleLoadSuccess) {
        final schedules = currentState.schedules;
        for (final group in schedules) {
          for (var schedule in group) {
            if (schedule.id == event.scheduleId) {
              schedule.studentRequest = event.request;
            }
          }
        }

        emit(ScheduleLoadSuccess(schedules));
      }
    } catch (e) {
      emit(ScheduleLoadFailure(e.toString()));
    }
  }
}
