// meeting_state.dart
part of 'meeting_bloc.dart';

abstract class MeetingState extends Equatable {
  const MeetingState();

  @override
  List<Object> get props => [];
}

class MeetingInitial extends MeetingState {}

class MeetingCreating extends MeetingState {
  const MeetingCreating();

  @override
  List<Object> get props => [];
}

class MeetingJoined extends MeetingState {
  const MeetingJoined();

  @override
  List<Object> get props => [];
}

class MeetingLeft extends MeetingState {}

class MeetingError extends MeetingState {
  final String message;

  const MeetingError(this.message);

  @override
  List<Object> get props => [message];
}

class MeetingWaiting extends MeetingState {
  final DateTime dateTime;

  const MeetingWaiting(this.dateTime);

  @override
  List<Object> get props => [dateTime];
}
