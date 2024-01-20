import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/data/models/schedule/booked_schedule.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/routes.dart';

class VideoCallScreen extends StatefulWidget {
  final BookedSchedule bookedSchedule;
  const VideoCallScreen({super.key, required this.bookedSchedule});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late DateTime startTime;

  @override
  Widget build(BuildContext context) {
    startTime = DateTime.fromMillisecondsSinceEpoch(
        widget.bookedSchedule.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
    String dateStart = DateFormat('EEE, dd MMM yy').format(startTime);
    String timeStart = DateFormat('HH:mm').format(startTime);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<int>(
                    stream:
                        Stream.periodic(const Duration(seconds: 1), (i) => i),
                    builder: (context, snapshot) {
                      final countdownDuration =
                          startTime.difference(DateTime.now());
                      final countdownString =
                          '${countdownDuration.inHours}:${(countdownDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(countdownDuration.inSeconds % 60).toString().padLeft(2, '0')}';
                      return Text(
                        '$countdownString until lesson start ($dateStart $timeStart)',
                        style: const TextStyle(
                            fontSize: 24, color: Colors.white60),
                      );
                    },
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                    child: MyElevatedButton(
                        text: 'Cancel',
                        color: Colors.white60,
                        textColor: Colors.white,
                        height: 48,
                        radius: 8,
                        onPressed: () {
                          Navigator.pop(context);
                        })),
                const SizedBox(width: 10),
                Expanded(
                    child: MyElevatedButton(
                        text: 'Connect',
                        height: 48,
                        radius: 8,
                        onPressed: () async {
                          final routeContext = context;
                          await Navigator.pushNamed(
                              routeContext, Routes.meetingPage,
                              arguments:
                                  widget.bookedSchedule.studentMeetingLink);
                          if (mounted) {
                            Navigator.pop(routeContext);
                          }
                        })),
                const SizedBox(width: 5),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
