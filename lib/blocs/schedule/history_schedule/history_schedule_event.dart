import 'package:equatable/equatable.dart';

abstract class HistoryScheduleEvent extends Equatable {
  const HistoryScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetHistoryScheduleList extends HistoryScheduleEvent {
  const GetHistoryScheduleList({required this.page});

  final int page;

  @override
  List<Object> get props => [page];
}
