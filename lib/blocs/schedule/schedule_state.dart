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
  final bool isCancelSuccess;

  const ScheduleLoadSuccess(this.schedules, {this.isCancelSuccess = false});

  @override
  List<Object> get props => [schedules, isCancelSuccess];

  ScheduleLoadSuccess copyWith(
      {List<List<BookedSchedule>>? schedules, bool? isCancelSuccess}) {
    return ScheduleLoadSuccess(schedules ?? this.schedules,
        isCancelSuccess: isCancelSuccess ?? this.isCancelSuccess);
  }
}

class ScheduleLoadFailure extends ScheduleState {
  final String message;

  const ScheduleLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
