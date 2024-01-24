import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_bloc.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_event.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_state.dart';
import 'package:let_tutor/data/models/schedule/schedule_slot.dart';
import 'package:let_tutor/presentation/screen/tutor/booking/booking_page_failed.dart';
import 'package:let_tutor/presentation/screen/tutor/booking/widgets/calendar_picker.dart';
import 'package:let_tutor/presentation/screen/tutor/booking/widgets/time_picker.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class BookingPage extends StatefulWidget {
  final String tutorId;
  const BookingPage({Key? key, required this.tutorId}) : super(key: key);

  @override
  BookingPageState createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  late DateTime _selectedDate;
  ScheduleSlot? _selectedSlot;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          _showDialog('Success', state.message, Icons.check_circle_outline);
        } else if (state is BookingFailure) {
          _showDialog('Failure', state.error, Icons.error_outline);
        }
      },
      builder: (context, state) {
        if (state is BookingLoadSuccess) {
          if (state.availableSlots.isEmpty) {
            return const Text('No available date');
          }

          _selectedDate = state.selectedDate;
          _selectedSlot = state.availableSlots[_selectedDate]?.first;

          log('balance: ${state.balance}');
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
                  CalendarPicker(
                      availableDate: state.availableSlots.keys.toList()),
                  header(context, 'Booking time'),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: state.availableSlots[_selectedDate] != null
                          ? TimePicker(
                              availableSlots:
                                  state.availableSlots[_selectedDate]!,
                              onChanged: (ScheduleSlot slot) {
                                _selectedSlot = slot;
                              },
                            )
                          : const Text('No available time on this date')),
                  const SizedBox(height: 16),
                  balanceInformation(state.balance),
                  const SizedBox(height: 16),
                  priceInformation(),
                  const SizedBox(height: 16),
                  Expanded(child: Container()),
                  bookButton(state.balance),
                ],
              ),
            ),
          );
        } else if (state is BookingLoadFailure) {
          return BookingPageFailed(error: state.error);
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

  Widget header(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: CustomTextStyle.headlineMedium,
      ),
    );
  }

  Widget timePicker(List<ScheduleSlot> availableSlots) {
    if (availableSlots.isEmpty) {
      _selectedSlot = null;
    } else if (_selectedSlot == null ||
        !availableSlots.contains(_selectedSlot)) {
      _selectedSlot = availableSlots.first;
    }

    List<String> availableTimes =
        availableSlots.map((slot) => slot.timeRange).toList();

    return Row(
      children: [
        // icon
        const Icon(Icons.access_time),
        const SizedBox(width: 8),
        DropdownButton<String>(
          value: _selectedSlot?.timeRange ?? availableTimes.first,
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
              _selectedSlot = availableSlots
                  .firstWhere((slot) => slot.timeRange == newValue);
            });
          },
        )
      ],
    );
  }

  Widget priceInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Price:',
          style: CustomTextStyle.headlineMedium,
        ),
        const Text(
          '1 lesson',
          style: TextStyle(fontSize: 18, color: Color(0xFF0058C6)),
        ),
      ],
    );
  }

  balanceInformation(int balance) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Balance:',
          style: CustomTextStyle.headlineMedium,
        ),
        Text(
          'You have $balance lessons left',
          style: const TextStyle(fontSize: 18, color: Color(0xFF0058C6)),
        ),
      ],
    );
  }

  Widget bookButton(int balance) {
    return MyElevatedButton(
        text: 'Book now',
        height: 50,
        radius: 8,
        onPressed: () {
          _showConfirmDialog(context, balance);
        });
  }

  void _showConfirmDialog(BuildContext context, int balance) {
    final textController = TextEditingController();
    BuildContext originalContext = context;

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
                  _selectedSlot?.timeRange ?? '',
                  style: const TextStyle(color: Color(0xFF0058C6)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Balance:',
                ),
                Text(
                  '$balance lessons left',
                  style: const TextStyle(color: Color(0xFF0058C6)),
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
            onPressed: () {
              BlocProvider.of<BookingBloc>(originalContext).add(BookTutor(
                  _selectedDate,
                  _selectedSlot!.scheduleId,
                  textController.text));
              Navigator.pop(context);
            },
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

  void _showDialog(String title, String message, IconData icon) {
    BuildContext originalContext = context;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            MyElevatedButton(
              text: 'OK',
              height: 25,
              radius: 5,
              onPressed: () {
                Navigator.pop(context);
                originalContext
                    .read<BookingBloc>()
                    .add(BookingInitialRequested(tutorId: widget.tutorId));
              },
              width: 26,
              textSize: 18,
            ),
          ],
        );
      },
    );
  }
}
