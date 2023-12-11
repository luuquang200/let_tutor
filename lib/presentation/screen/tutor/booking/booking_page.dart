import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_bloc.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_state.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class BookingPage extends StatefulWidget {
  final String tutorId;
  const BookingPage({Key? key, required this.tutorId}) : super(key: key);

  @override
  BookingPageState createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = '00:00 - 00:00';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state is BookingLoadSuccess) {
          _selectedDate = state.availableSlots.keys.first;
          return Scaffold(
            appBar: AppBar(
                title: Text('Booking', style: CustomTextStyle.topHeadline),
                iconTheme:
                    IconThemeData(color: Theme.of(context).primaryColor)),
            body: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(context, 'Booking date'),
                  _CalendarPicker(
                      availableDate: state.availableSlots.keys.toList()),
                  header(context, 'Booking time'),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: state.availableSlots[_selectedDate] != null
                          ? timePicker(state.availableSlots[_selectedDate]!)
                          : const Text('No available time on this date')),
                  const SizedBox(height: 16),
                  balanceInformation(),
                  const SizedBox(height: 16),
                  priceInformation(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(),
                  ),
                  bookButton(),
                ],
              ),
            ),
          );
        } else if (state is BookingLoadFailure) {
          return const Text('Failed to load booking data');
        } else {
          return const Center(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void _selectTime(BuildContext context) async {
    final List<String> availableHours = [
      '18:30 - 18:55',
      '19:00 - 19:25',
      '20:00 - 20:25',
      '20:30 - 20:55',
      '21:00 - 21:25'
    ];
    String? selectedHour = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select an available hour'),
          children: availableHours
              .map((hour) => SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, hour);
                    },
                    child: Text(hour),
                  ))
              .toList(),
        );
      },
    );
    if (selectedHour != null) {
      setState(() {
        _selectedTime = selectedHour;
      });
    }
  }

  Widget header(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: CustomTextStyle.headlineMedium,
      ),
    );
  }

  Widget timePicker(List<String> availableTimes) {
    if (availableTimes.isEmpty) {
      _selectedTime = "";
    } else if (!availableTimes.contains(_selectedTime)) {
      _selectedTime = availableTimes.first;
    }

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // icon
        const Icon(Icons.access_time),
        const SizedBox(width: 8),
        DropdownButton<String>(
          value: _selectedTime,
          items: availableTimes.map<DropdownMenuItem<String>>((String value) {
            final List<String> times = value.split(' - ');
            final String startTime = formatTime(times[0]);
            final String endTime = formatTime(times[1]);
            final String displayValue = '$startTime - $endTime';
            return DropdownMenuItem<String>(
              value: value,
              child: Text(displayValue),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedTime = newValue!;
            });
          },
        )
      ],
    );
  }

  Widget priceInformation() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Price:',
          style: CustomTextStyle.headlineMedium,
        ),
        Text(
          '1 lesson',
          style: TextStyle(fontSize: 18, color: Color(0xFF0058C6)),
        ),
      ],
    );
  }

  balanceInformation() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Balance:',
          style: CustomTextStyle.headlineMedium,
        ),
        Text(
          'You have 9664 lessons left',
          style: TextStyle(fontSize: 18, color: Color(0xFF0058C6)),
        ),
      ],
    );
  }

  Widget bookButton() {
    return MyElevatedButton(
        text: 'Book now',
        height: 50,
        radius: 8,
        onPressed: () {
          _showConfirmDialog(context);
        });
  }

  void _showConfirmDialog(BuildContext context) {
    final textController =
        TextEditingController(); // controller để lấy giá trị của TextField
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Booking Date:',
                ),
                Text(
                  DateFormat('E, d MMM yyyy').format(_selectedDate),
                  style: const TextStyle(color: Color(0xFF0058C6)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lesson Time: :',
                ),
                Text(
                  _selectedTime,
                  style: const TextStyle(color: Color(0xFF0058C6)),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Balance:',
                ),
                Text(
                  '9664 lessons left',
                  style: TextStyle(color: Color(0xFF0058C6)),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price:',
                ),
                Text(
                  '1 lesson',
                  style: TextStyle(color: Color(0xFF0058C6)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Request for Tutor:'),
            const SizedBox(height: 8),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Enter your request here',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
          ],
        ),
        actions: [
          MyOutlineButton(
            text: 'Cancel',
            height: 25,
            radius: 5,
            onPressed: () => Navigator.pop(context),
            width: 26,
            textSize: 18,
          ),
          MyElevatedButton(
            text: 'Book',
            height: 25,
            radius: 5,
            onPressed: () => Navigator.pop(context),
            width: 26,
            textSize: 18,
          )
        ],
      ),
    );
  }

  String formatTime(String time) {
    final int hour = int.parse(time.split(':')[0]);
    final String suffix = hour >= 12 ? 'PM' : 'AM';
    return '$time $suffix';
  }
}

class _CalendarPicker extends StatelessWidget {
  const _CalendarPicker({Key? key, required this.availableDate})
      : super(key: key);

  final List<DateTime> availableDate;
  @override
  Widget build(BuildContext context) {
    // sort availableDate
    availableDate.sort((a, b) => a.compareTo(b));

    // remove date before today
    // DateTime today = DateTime.(DateTime.now().year, DateTime.now().month, DateTime.now().day));
    // availableDate.removeWhere((date) => date.isBefore(today));

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
      onDateChanged: (DateTime value) {},
    );
  }
}
