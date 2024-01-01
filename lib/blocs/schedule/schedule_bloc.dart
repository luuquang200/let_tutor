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
}
