import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/schedule/booking.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_list/tutor_list_page.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/flag.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';
import 'package:let_tutor/routes.dart';

class BookedScheduleCard extends StatefulWidget {
  const BookedScheduleCard({Key? key, required this.bookedSchedules})
      : super(key: key);
  final List<BookedSchedule> bookedSchedules;

  @override
  State<BookedScheduleCard> createState() => _BookedScheduleCardState();
}

class _BookedScheduleCardState extends State<BookedScheduleCard> {
  String? locale;
  @override
  void initState() {
    loadLocale();
    super.initState();
  }

  Future<void> loadLocale() async {
    locale = await getLocale();
    log('locale: $locale');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.bookedSchedules.first.scheduleDetailInfo
            ?.scheduleInfo?.tutorInfo?.avatar ??
        '';
    String tutorName = widget.bookedSchedules.first.scheduleDetailInfo
            ?.scheduleInfo?.tutorInfo?.name ??
        '';
    String country = widget.bookedSchedules.first.scheduleDetailInfo
            ?.scheduleInfo?.tutorInfo?.country ??
        '';
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
        widget.bookedSchedules.first.scheduleDetailInfo?.startPeriodTimestamp ??
            0);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const SizedBox(width: 12),
                TutorAvatar(imageUrl: imageUrl, tutorName: tutorName),
                const SizedBox(width: 12),
                _tutorInfo(context, tutorName, country),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _dateInfor(startTime),
            // _timeInfo(startTime, endTime),
            Column(
              children: widget.bookedSchedules
                  .map(
                      (schedule) => _DetailLessonTime(bookedSchedule: schedule))
                  .toList(),
            ),
            const SizedBox(
              height: 6,
            ),
            _goMeetingButton(context),
          ],
        ),
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
              // Navigator.pushNamed(context, Routes.teacherDetail);
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

  _goMeetingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyElevatedButton(
        text: 'Go to meeting',
        onPressed: () {
          Routes.navigateTo(context, Routes.videoCallScreen);
        },
        height: 45,
        width: double.infinity,
        radius: 5,
        textSize: 16,
      ),
    );
  }

  String _getNameCountry(String codeOrName) {
    final country = AppConfig.countries.firstWhere(
        (country) => country.code == codeOrName || country.name == codeOrName,
        orElse: () => Country(name: '', code: ''));
    return country.name;
  }

  _dateInfor(DateTime startTime) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.calendar_today_outlined, size: 22),
            const SizedBox(width: 12),
            Text(DateFormat('EEE, dd MMM yy', locale).format(startTime),
                style: CustomTextStyle.bodyRegular),
          ],
        ));
  }
}

Future<bool> showEditRequestDialog(BuildContext context) async {
  final textController = TextEditingController();
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Request for Tutor'),
      content: TextField(
        controller: textController,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: 'Enter your request here',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text('Send'),
        ),
      ],
    ),
  );
  return result ?? false;
}

class _DetailLessonTime extends StatefulWidget {
  final BookedSchedule bookedSchedule;

  const _DetailLessonTime({Key? key, required this.bookedSchedule})
      : super(key: key);

  @override
  _DetailLessonTimeState createState() => _DetailLessonTimeState();
}

class _DetailLessonTimeState extends State<_DetailLessonTime> {
  bool isRequestExpanded = false;
  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
        widget.bookedSchedule.scheduleDetailInfo?.startPeriodTimestamp ?? 0);
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(
        widget.bookedSchedule.scheduleDetailInfo?.endPeriodTimestamp ?? 0);

    return Column(
      children: [
        _separatorDivider(),
        SizedBox(
          width: double.infinity, // Set a specific width
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _timeInfo(startTime, endTime),
              MyOutlineButton(
                text: 'Cancel',
                onPressed: () {},
                height: 33,
                width: 100,
                radius: 3,
                textSize: 16,
                color: Colors.red,
              ),
            ],
          ),
        ),
        _requestForLesson(context),
      ],
    );
  }

  _timeInfo(DateTime startTime, DateTime endTime) {
    String time =
        '${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)}';
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.access_time_outlined, size: 22),
            const SizedBox(width: 12),
            Text(time, style: CustomTextStyle.bodyRegular)
          ],
        ));
  }

  _separatorDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 8),
      child: Column(
        children: [
          SizedBox(height: 8),
          Divider(height: 1, color: Color.fromARGB(255, 200, 197, 197)),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  _requestForLesson(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            Row(
              children: [
                // _showEditRequestButton(context),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isRequestExpanded = !isRequestExpanded;
                    });
                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    isRequestExpanded
                        ? Icons.keyboard_arrow_down_sharp
                        : Icons.keyboard_arrow_right_sharp,
                  ),
                  iconSize: 32,
                ),
                const Expanded(
                    child: Row(
                  children: [
                    Text('Requests for lesson:',
                        style: CustomTextStyle.bodyRegular),
                  ],
                )),
                _showEditRequestButton(context),
              ],
            ),
            if (isRequestExpanded)
              const Padding(
                padding: EdgeInsets.only(left: 48, right: 8),
                child: Text(
                  'I would like to learn about the history of the internet',
                ),
              ),
          ],
        ));
  }

  _showEditRequestButton(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final dialogResult = await showEditRequestDialog(context);
        },
        icon: Icon(
          Icons.edit_note_outlined,
          size: 28,
          color: Colors.blue[700],
        ));
  }
}
