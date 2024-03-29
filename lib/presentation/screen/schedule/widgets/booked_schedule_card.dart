import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/schedule/booked_schedule/schedule_bloc.dart';
import 'package:let_tutor/blocs/schedule/booked_schedule/schedule_event.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/schedule/booked_schedule.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/styles/theme.dart';
import 'package:let_tutor/presentation/widgets/flag.dart';
import 'package:let_tutor/presentation/widgets/separator_divider.dart';
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
    super.initState();
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
    locale = context.locale.languageCode;
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
            Column(
              children: widget.bookedSchedules
                  .map(
                      (schedule) => _DetailLessonTime(bookedSchedule: schedule))
                  .toList(),
            ),
            const SizedBox(
              height: 6,
            ),
            _goMeetingButton(context, widget.bookedSchedules.first),
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
                color: AppTheme.primaryColor,
              ),
              const SizedBox(width: 4),
              Text(
                'direct_message'.tr(),
                style: CustomTextStyle.bodyRegular
                    .copyWith(color: AppTheme.primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  _goMeetingButton(BuildContext context, BookedSchedule bookedSchedule) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyElevatedButton(
        text: 'go_to_meeting'.tr(),
        onPressed: () {
          Navigator.pushNamed(context, Routes.videoCallScreen,
              arguments: bookedSchedule);
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
            const Icon(Icons.calendar_today_outlined, size: 22, weight: 2),
            const SizedBox(width: 12),
            Text(DateFormat('EEEE, dd MMM yyyy', locale).format(startTime),
                style: CustomTextStyle.bodyLarge),
          ],
        ));
  }
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
    String tutorName = widget
            .bookedSchedule.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name ??
        '';
    String time =
        '${DateFormat('hh:mm a', context.locale.languageCode).format(startTime)} - ${DateFormat('hh:mm a', context.locale.languageCode).format(endTime)}';

    return Column(
      children: [
        const SeparatorDivider(marginLeft: 8.0, marginRight: 0),
        SizedBox(
          width: double.infinity, // Set a specific width
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _timeInfo(time),
              // Check if the start time is more than 2 hours from now
              if (startTime.difference(DateTime.now()).inHours >= 2)
                MyOutlineButton(
                  text: 'Cancel',
                  onPressed: () async {
                    final originContext = context;
                    final dialogResult = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: const Text('Cancel lesson'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TutorAvatar(
                                      imageUrl: widget
                                              .bookedSchedule
                                              .scheduleDetailInfo
                                              ?.scheduleInfo
                                              ?.tutorInfo
                                              ?.avatar ??
                                          '',
                                      tutorName: tutorName,
                                      radius: 38),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(tutorName,
                                          style: CustomTextStyle.headlineLarge),
                                      Text(
                                          DateFormat('EEEE, dd MMM yyyy',
                                                  context.locale.languageCode)
                                              .format(startTime),
                                          style: CustomTextStyle.bodyRegular),
                                      Text(time,
                                          style: CustomTextStyle.bodyRegular),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text('cancel_lesson_confirm'.tr(),
                                  style: CustomTextStyle.bodyLarge),
                            ],
                          ),
                          actions: [
                            MyOutlineButton(
                              text: 'no'.tr(),
                              height: 25,
                              radius: 5,
                              onPressed: () => Navigator.pop(context, false),
                              width: 26,
                              textSize: 18,
                            ),
                            MyElevatedButton(
                              text: 'yes'.tr(),
                              height: 25,
                              radius: 5,
                              onPressed: () => Navigator.pop(context, true),
                              width: 26,
                              textSize: 18,
                            )
                          ]),
                    );
                    if (dialogResult ?? false) {
                      BlocProvider.of<ScheduleBloc>(originContext)
                          .add(CancelSchedule(widget.bookedSchedule.id ?? ''));
                    }
                  },
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

  _timeInfo(String time) {
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

  _requestForLesson(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
                Expanded(
                    child: Row(
                  children: [
                    Text('requests_for_lesson'.tr(),
                        style: CustomTextStyle.bodyRegular),
                  ],
                )),
                _showEditRequestButton(context),
              ],
            ),
            if (isRequestExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 41, right: 6),
                child: Text(
                    widget.bookedSchedule.studentRequest ?? 'no_requests'.tr()),
              ),
          ],
        ));
  }

  _showEditRequestButton(BuildContext context) {
    return IconButton(
        onPressed: () async {
          // final dialogResult = await showEditRequestDialog(context,  widget.bookedSchedule.studentRequest ?? '');final textController = TextEditingController();
          TextEditingController textController = TextEditingController();
          textController.text = widget.bookedSchedule.studentRequest ?? '';
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('requests_for_lesson'.tr()),
              content: TextField(
                controller: textController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'enter_request'.tr(),
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('cancel'.tr()),
                ),
                TextButton(
                  onPressed: () {
                    if (textController.text.trim().isNotEmpty) {
                      Navigator.pop(context, true);
                    } else {
                      // show a message to the user
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                              content: Text(
                            'enter_request_before_sending'.tr(),
                          )),
                        );
                    }
                  },
                  child: Text('send'.tr()),
                ),
              ],
            ),
          );

          if (result ?? false) {
            BlocProvider.of<ScheduleBloc>(context).add(UpdateRequest(
                widget.bookedSchedule.id ?? '', textController.text));
          }
        },
        icon: Icon(
          Icons.edit_note_outlined,
          size: 28,
          color: Colors.blue[700],
        ));
  }
}
