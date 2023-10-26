import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();
  final List<DateTime> _availableDates = [
    DateTime(2023, 10, 28),
    DateTime(2023, 10, 30),
    DateTime(2023, 10, 31),
  ];

  String _selectedTime = '00:00 - 00:00';

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
        // final hourParts = selectedHour.split(' - ');
        // final hour = hourParts[0];
        // final minute = hourParts[1].split(':')[0];
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

  Widget calendarPicker() {
    return CalendarDatePicker(
      initialDate: _availableDates.first,
      firstDate: _availableDates.first,
      lastDate: DateTime(2024),
      onDateChanged: (DateTime selected) {
        setState(() {
          _selectedDate = selected;
        });
      },
      selectableDayPredicate: (DateTime date) {
        return _availableDates.contains(date);
      },
    );
  }

  Widget timePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _selectedTime,
          style: const TextStyle(fontSize: 18, color: Color(0xFF0058C6)),
        ),
        // TextButton(
        //   onPressed: () => _selectTime(context),
        //   child: const Text('Select time'),
        // ),
        IconButton(
          onPressed: () => _selectTime(context),
          icon: const Icon(
            Icons.edit_outlined,
            color: Color(0xFF0058C6),
          ),
        ),
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
    return CustomElevatedButton(
        text: 'Book now', height: 50, radius: 8, onPressed: () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(context, 'Booking date'),
            calendarPicker(),
            header(context, 'Booking time'),
            Padding(
                padding: const EdgeInsets.only(left: 10), child: timePicker()),
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
  }
}
