import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();
  final List<DateTime> _availableDates = [
    DateTime(2023, 10, 28),
    DateTime(2023, 10, 30),
    DateTime(2023, 10, 31),
  ];

  String _selectedTime = '00:00 - 00:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Booking', style: CustomTextStyle.topHeadline),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
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
}
