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
  final DateTime selectedDate;
  final int balance;

  const BookingLoadSuccess(
      this.availableSlots, this.selectedDate, this.balance);

  @override
  List<Object> get props => [availableSlots, selectedDate, balance];

  BookingLoadSuccess copyWith({
    Map<DateTime, List<String>>? availableSlots,
    DateTime? selectedDate,
    int? balance,
  }) {
    return BookingLoadSuccess(
      availableSlots ?? this.availableSlots,
      selectedDate ?? this.selectedDate,
      balance ?? this.balance,
    );
  }
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
