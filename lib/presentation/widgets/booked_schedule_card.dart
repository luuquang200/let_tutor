import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/routes.dart';

class BookedScheduleCard extends StatefulWidget {
  const BookedScheduleCard({super.key});

  @override
  State<BookedScheduleCard> createState() => _BookedScheduleCardState();
}

class _BookedScheduleCardState extends State<BookedScheduleCard> {
  bool isRequestExpanded = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                _tutorAvatar(context),
                const SizedBox(width: 12),
                _tutorInfo(context),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _timeInfo(),
            const SizedBox(
              height: 6,
            ),
            _requestForLesson(context),
            Row(
              children: [
                _cancelButton(context),
                const SizedBox(width: 12),
                _goMeetingButton(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  _tutorInfo(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, Routes.teacherDetail);
            },
            child: const Text(
              'Keegan',
              style: CustomTextStyle.headlineLarge,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              SvgPicture.asset(
                'assets/flags/Tunisia.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 4),
              const Text(
                'Tunisia',
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

  _tutorAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.navigateTo(context, Routes.tutorDetail);
      },
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/tutor_avatar.jpg'),
        radius: 44,
      ),
    );
  }

  _cancelButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.red),
        onPressed: () {},
        child: const Text(
          'Cancel',
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
    );
  }

  _goMeetingButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          Routes.navigateTo(context, Routes.videoCallScreen);
        },
        child: const Text(
          'Go to meeting',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
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

  _timeInfo() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          children: [
            SizedBox(width: 14),
            Icon(Icons.calendar_today_outlined, size: 22),
            SizedBox(width: 12),
            Text('Monday, 31 Oct 2023', style: CustomTextStyle.bodyRegular),
            SizedBox(width: 18),
            Icon(Icons.access_time_outlined, size: 22),
            SizedBox(width: 3),
            Flexible(
              child:
                  Text('10:00 - 10:15 AM', style: CustomTextStyle.bodyRegular),
            ),
          ],
        ));
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
