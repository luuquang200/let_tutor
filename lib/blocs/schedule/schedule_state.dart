import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/schedule/booking.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoadSuccess extends ScheduleState {
  final List<List<BookedSchedule>> schedules;

  const ScheduleLoadSuccess(this.schedules);

  @override
  List<Object> get props => [schedules];

  ScheduleLoadSuccess copyWith({List<List<BookedSchedule>>? schedules}) {
    return ScheduleLoadSuccess(schedules ?? this.schedules);
  }
}

class ScheduleLoadFailure extends ScheduleState {
  final String message;

  const ScheduleLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
