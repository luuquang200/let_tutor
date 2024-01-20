part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class CreateMeetingEvent extends MeetingEvent {
  final String url;

  const CreateMeetingEvent(this.url);

  @override
  List<Object> get props => [url];
}

class LeaveMeetingEvent extends MeetingEvent {}
