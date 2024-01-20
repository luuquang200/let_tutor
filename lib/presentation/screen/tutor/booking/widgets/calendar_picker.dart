import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_bloc.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_event.dart';

class CalendarPicker extends StatelessWidget {
  const CalendarPicker({Key? key, required this.availableDate})
      : super(key: key);

  final List<DateTime> availableDate;
  @override
  Widget build(BuildContext context) {
    // sort availableDate
    availableDate.sort((a, b) => a.compareTo(b));

    if (availableDate.isEmpty) {
      return const Text("No available dates");
    }

    DateTime lastDate = DateTime.now().add(const Duration(days: 365));
    return CalendarDatePicker(
      initialDate: availableDate.first,
      firstDate: availableDate.first,
      lastDate: lastDate,
      selectableDayPredicate: (DateTime date) {
        return availableDate.contains(date);
      },
      onDateChanged: (DateTime value) {
        BlocProvider.of<BookingBloc>(context).add(SelectDate(value));
      },
    );
  }
}
