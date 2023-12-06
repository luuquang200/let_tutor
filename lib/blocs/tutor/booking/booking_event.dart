import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class BookingInitialRequested extends BookingEvent {
  final String tutorId;

  const BookingInitialRequested({required this.tutorId});

  @override
  List<Object> get props => [tutorId];
}

class SelectDate extends BookingEvent {
  final DateTime selectedDate;

  const SelectDate(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

class SelectTime extends BookingEvent {
  final String selectedTime;

  const SelectTime(this.selectedTime);

  @override
  List<Object> get props => [selectedTime];
}

class BookTutor extends BookingEvent {
  const BookTutor();

  @override
  List<Object> get props => [];
}
