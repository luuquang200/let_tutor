import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_event.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_state.dart';
import 'package:let_tutor/data/models/tutors/tutor_schedule.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final TutorRepository tutorRepository;
  DateTime selectedDate = DateTime.now();
  int balance = 0;

  BookingBloc({required this.tutorRepository}) : super(BookingInitial()) {
    on<BookingInitialRequested>(_onBookingInitialRequested);
    on<SelectDate>(_onSelectDate);
    on<SelectTime>(_onSelectTime);
    on<BookTutor>(_onBookTutor);
  }

  FutureOr<void> _onBookingInitialRequested(
      BookingInitialRequested event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final List<TutorSchedule> schedules =
          await tutorRepository.getScheduleOfTutor(event.tutorId);
      if (schedules.isEmpty) {
        emit(const BookingLoadFailure('No available slots'));
        return;
      }
      User user = await tutorRepository.getUser(event.tutorId);
      balance = (int.parse(user.walletInfo?.amount ?? '0') / 10000).floor();
      Map<DateTime, List<String>> availableSlots = {};

      for (var schedule in schedules) {
        for (var detail in schedule.scheduleDetails) {
          if (!detail.isBooked) {
            DateTime startDate =
                DateTime.fromMillisecondsSinceEpoch(detail.startPeriodTimestamp)
                    .toLocal();
            DateTime dateOnly =
                DateTime(startDate.year, startDate.month, startDate.day);
            // log('From booking_bloc.dart: $dateOnly');

            String startTime = detail.startPeriod;
            String endTime = detail.endPeriod;
            String timeRange = "$startTime - $endTime";

            if (!availableSlots.containsKey(dateOnly)) {
              availableSlots[dateOnly] = [timeRange];
            } else {
              availableSlots[dateOnly]!.add(timeRange);
            }
          }
        }
      }

      selectedDate = availableSlots.keys.first;

      log(availableSlots.toString());
      emit(BookingLoadSuccess(availableSlots, selectedDate, balance));
    } catch (error) {
      log('Error from booking_bloc.dart: $error');
      emit(BookingLoadFailure(error.toString()));
    }
  }

  FutureOr<void> _onSelectDate(
      SelectDate event, Emitter<BookingState> emit) async {
    final currentState = state as BookingLoadSuccess;
    emit(BookingLoading());

    try {
      selectedDate = event.selectedDate;
      emit(currentState.copyWith(selectedDate: selectedDate));
    } catch (error) {
      log('Error from booking_bloc.dart: $error');
      emit(BookingLoadFailure(error.toString()));
    }
  }

  FutureOr<void> _onSelectTime(
      SelectTime event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
  }

  FutureOr<void> _onBookTutor(
      BookTutor event, Emitter<BookingState> emit) async {
    emit(BookingBookLoading());
  }
}
