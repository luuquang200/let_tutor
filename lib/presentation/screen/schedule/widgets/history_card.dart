import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/schedule/booked_schedule.dart';
import 'package:let_tutor/presentation/screen/schedule/widgets/history_request.dart';
import 'package:let_tutor/presentation/screen/schedule/widgets/history_review.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/flag.dart';
import 'package:let_tutor/presentation/widgets/separator_divider.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';
import 'package:let_tutor/routes.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({super.key, required this.bookedSchedule});
  final BookedSchedule bookedSchedule;
  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.bookedSchedule.scheduleDetailInfo?.scheduleInfo
            ?.tutorInfo?.avatar ??
        '';
    String tutorName = widget
            .bookedSchedule.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name ??
        '';
    String country = widget.bookedSchedule.scheduleDetailInfo?.scheduleInfo
            ?.tutorInfo?.country ??
        '';
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
        widget.bookedSchedule.scheduleDetailInfo?.startPeriodTimestamp ?? 0);

    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(
        widget.bookedSchedule.scheduleDetailInfo?.endPeriodTimestamp ?? 0);

    String time =
        '${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)}';

    String date = DateFormat('EEEE, dd MMM yyyy').format(startTime);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 12),
                TutorAvatar(
                    imageUrl: imageUrl, tutorName: tutorName, radius: 44),
                const SizedBox(width: 12),
                _tutorInfo(context, tutorName, country),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _dateInfo(date),
            const SeparatorDivider(marginLeft: 8.0, marginRight: 8.0),
            _timeInfo(time),
            HistoryRequest(request: widget.bookedSchedule.studentRequest),
            HistoryReview(review: widget.bookedSchedule.tutorReview),
            Row(
              children: [
                _reportButton(context,
                    imageUrl: imageUrl, tutorName: tutorName),
                const SizedBox(width: 12),
                _addRatingButton(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showReportDialog(BuildContext context,
      {String imageUrl = '', String tutorName = ''}) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report on Lesson'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // _tutorAvatar(context, 32),
                TutorAvatar(imageUrl: imageUrl, tutorName: tutorName),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Krystal', style: CustomTextStyle.headlineLarge),
                    // Text('Lesson Time: '),
                    Text('Monday, 31 Oct 2023'),
                    Text('10:00 - 10:15 AM'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('What was the reason you reported on the lesson?',
                style: CustomTextStyle.bodyRegular),
            const SizedBox(height: 8),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Enter your report here',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
          ],
        ),
        actions: [
          MyOutlineButton(
            text: 'Later',
            height: 25,
            radius: 5,
            onPressed: () => Navigator.pop(context),
            width: 26,
            textSize: 18,
          ),
          MyElevatedButton(
            text: 'Submit',
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

  _tutorInfo(BuildContext context, String tutorName, String country) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Routes.navigateTo(context, Routes.tutorDetail);
            },
            child: Text(
              tutorName,
              style: CustomTextStyle.headlineLarge,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Flag(flagCode: country),
              const SizedBox(width: 4),
              Text(
                _getNameCountry(country),
                style: CustomTextStyle.bodyRegular,
              ),
            ],
          ),
          const SizedBox(height: 3),
          // direct messeage
          Row(
            children: [
              Icon(
                Icons.message_outlined,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 4),
              Text(
                'Direct message',
                style: CustomTextStyle.bodyRegular
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _getNameCountry(String codeOrName) {
    final country = AppConfig.countries.firstWhere(
        (country) => country.code == codeOrName || country.name == codeOrName,
        orElse: () => Country(name: '', code: ''));
    return country.name;
  }

  _reportButton(BuildContext context,
      {String imageUrl = '', String tutorName = ''}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.red),
        onPressed: () {
          _showReportDialog(context, imageUrl: imageUrl, tutorName: tutorName);
        },
        child: const Text(
          'Report',
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
    );
  }

  _addRatingButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          Routes.navigateTo(context, Routes.writeReview);
        },
        child: const Text(
          'Add a rating',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  _dateInfo(String date) {
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 6),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 20, weight: 2),
            const SizedBox(width: 8),
            Text(date, style: CustomTextStyle.bodyLarge),
            const SizedBox(width: 16),
          ],
        ));
  }

  _timeInfo(String time) {
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 6, top: 14, bottom: 8),
        child: Row(
          children: [
            const Icon(Icons.access_time_outlined, size: 20),
            const SizedBox(width: 8),
            Text(time, style: CustomTextStyle.bodyRegular)
          ],
        ));
  }
}
