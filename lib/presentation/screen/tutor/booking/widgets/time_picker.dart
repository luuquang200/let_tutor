import 'package:flutter/material.dart';
import 'package:let_tutor/data/models/schedule/schedule_slot.dart';

class TimePicker extends StatefulWidget {
  final List<ScheduleSlot> availableSlots;
  final ValueChanged<ScheduleSlot> onChanged;

  const TimePicker({
    Key? key,
    required this.availableSlots,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  ScheduleSlot? _selectedSlot;

  @override
  void initState() {
    super.initState();
    if (widget.availableSlots.isNotEmpty) {
      _selectedSlot = widget.availableSlots.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> availableTimes =
        widget.availableSlots.map((slot) => slot.timeRange).toList();

    return Row(
      children: [
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
              _selectedSlot = widget.availableSlots
                  .firstWhere((slot) => slot.timeRange == newValue);
            });
            widget.onChanged(_selectedSlot!);
          },
        )
      ],
    );
  }

  String formatTime(String time) {
    final int hour = int.parse(time.split(':')[0]);
    final String suffix = hour >= 12 ? 'PM' : 'AM';
    return '$time $suffix';
  }
}
