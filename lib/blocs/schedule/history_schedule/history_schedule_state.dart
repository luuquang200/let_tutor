import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/schedule/booked_schedule.dart';

abstract class HistoryScheduleState extends Equatable {
  const HistoryScheduleState();

  @override
  List<Object> get props => [];
}

class HistoryScheduleInitial extends HistoryScheduleState {}

class HistoryScheduleLoading extends HistoryScheduleState {}

class HistoryScheduleLoadSuccess extends HistoryScheduleState {
  final List<BookedSchedule> schedules;
  final int totalPage;
  final int page;

  const HistoryScheduleLoadSuccess(
    this.schedules,
    this.totalPage,
    this.page,
  );

  @override
  List<Object> get props => [schedules, totalPage, page];

  HistoryScheduleLoadSuccess copyWith(
      {List<BookedSchedule>? schedules, bool? isCancelSuccess}) {
    return HistoryScheduleLoadSuccess(
        schedules ?? this.schedules, totalPage, page);
  }
}

class HistoryScheduleLoadFailure extends HistoryScheduleState {
  final String message;

  const HistoryScheduleLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
