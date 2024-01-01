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
