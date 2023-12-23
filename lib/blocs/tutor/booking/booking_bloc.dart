import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_event.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_state.dart';
import 'package:let_tutor/data/models/schedule/schedule_slot.dart';
import 'package:let_tutor/data/models/tutors/tutor_schedule.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';
import 'package:let_tutor/data/sharedpref/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final TutorRepository tutorRepository;
  late SharedPreferenceHelper sharedPrefsHelper;
  DateTime selectedDate = DateTime.now();
  int balance = 0;

  BookingBloc({required this.tutorRepository}) : super(BookingInitial()) {
    _getPres();
    on<BookingInitialRequested>(_onBookingInitialRequested);
    on<SelectDate>(_onSelectDate);
    on<SelectTime>(_onSelectTime);
    on<BookTutor>(_onBookTutor);
  }

  void _getPres() async {
    sharedPrefsHelper =
        SharedPreferenceHelper(await SharedPreferences.getInstance());
  }

  FutureOr<void> _onBookingInitialRequested(
      BookingInitialRequested event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final List<TutorSchedule> schedules =
          await tutorRepository.getScheduleOfTutor(event.tutorId);

      log('schedules: $schedules');
      for (var schedule in schedules) {
        log('schedule: $schedule');
        for (var detail in schedule.scheduleDetails) {
          log('detail: $detail');
        }
      }

      if (schedules.isEmpty) {
        emit(const BookingLoadFailure('No available slots'));
        return;
      }

      User user =
          await tutorRepository.getUser(await sharedPrefsHelper.userId ?? '0');

      balance = (int.parse(user.walletInfo?.amount ?? '0') / 100000).floor();
      Map<DateTime, List<ScheduleSlot>> availableSlots = {};

      for (var schedule in schedules) {
        for (var detail in schedule.scheduleDetails) {
          if (!detail.isBooked) {
            DateTime startDate =
                DateTime.fromMillisecondsSinceEpoch(detail.startPeriodTimestamp)
                    .toLocal();
            DateTime dateOnly =
                DateTime(startDate.year, startDate.month, startDate.day);

            // check if date is in the past
            DateTime now = DateTime.now();
            DateTime today = DateTime(now.year, now.month, now.day);

            if (dateOnly.isBefore(today)) {
              continue;
            }

            // set time range
            String startTime = detail.startPeriod;
            String endTime = detail.endPeriod;
            String timeRange = "$startTime - $endTime";

            ScheduleSlot slot = ScheduleSlot(detail.id, timeRange);

            if (!availableSlots.containsKey(dateOnly)) {
              availableSlots[dateOnly] = [slot];
            } else {
              availableSlots[dateOnly]!.add(slot);
            }
          }
        }
      }

      // sort the available dates
      availableSlots = Map.fromEntries(availableSlots.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key)));

      // sort the available slots
      for (var key in availableSlots.keys) {
        availableSlots[key]!.sort((a, b) => a.timeRange.compareTo(b.timeRange));
      }

      if (availableSlots.isEmpty) {
        emit(const BookingLoadFailure('No available slots'));
        return;
      }
      selectedDate = availableSlots.keys.first;

      log(availableSlots.toString());
      emit(BookingLoadSuccess(availableSlots, selectedDate, balance));
    } catch (error) {
      log('Error from booking load: $error');
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
    final currentState = state as BookingLoadSuccess;
    emit(BookingLoading());

    try {
      log('book tutor !');
      log(event.selectedId);
      log(event.note);
      log('done');
      await tutorRepository.bookTutor(event.selectedId, event.note);

      emit(const BookingSuccess('Booking successful'));
    } catch (error) {
      log('Error from _onBookTutor: $error');
      emit(BookingFailure('Booking failed: $error'));
    }
  }
}
