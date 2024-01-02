import 'package:equatable/equatable.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetScheduleList extends ScheduleEvent {
  const GetScheduleList();

  @override
  List<Object> get props => [];
}

class CancelSchedule extends ScheduleEvent {
  final String scheduleId;

  const CancelSchedule(this.scheduleId);

  @override
  List<Object> get props => [scheduleId];
}

class UpdateRequest extends ScheduleEvent {
  final String scheduleId;
  final String request;

  const UpdateRequest(this.scheduleId, this.request);

  @override
  List<Object> get props => [scheduleId, request];
}
