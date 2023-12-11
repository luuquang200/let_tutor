import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoadSuccess extends BookingState {
  final Map<DateTime, List<String>> availableSlots;

  const BookingLoadSuccess(this.availableSlots);

  @override
  List<Object> get props => [availableSlots];
}

class BookingLoadFailure extends BookingState {
  final String error;

  const BookingLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}

class BookingBookLoading extends BookingState {}

class BookingBookSuccess extends BookingState {}

class BookingBookFailed extends BookingState {
  final String error;

  const BookingBookFailed(this.error);

  @override
  List<Object> get props => [error];
}
