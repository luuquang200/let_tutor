import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/routes.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({super.key});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool isReviewExpanded = false;

  @override
  Widget build(BuildContext context) {
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
              height: 12,
            ),
            _requestForLesson(context),
            _reviewFromTutor(),
            Row(
              children: [
                _reportButton(context),
                const SizedBox(width: 12),
                _addRatingButton(context),
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
            child: Text(
              'Keegan',
              style: CustomTextStyle.headlineLarge,
            ),
          ),
          SizedBox(height: 2),
          Row(
            children: [
              SvgPicture.asset(
                'assets/flags/Tunisia.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(width: 4),
              Text(
                'Tunisia',
                style: CustomTextStyle.bodyRegular,
              ),
            ],
          ),
          SizedBox(height: 3),
          // direct messeage
          Row(
            children: [
              Icon(
                Icons.message_outlined,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 4),
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
        backgroundImage: AssetImage('assets/tutor_avatar_01.jpg'),
        radius: 44,
      ),
    );
  }

  _reportButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.red),
        onPressed: () {},
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
          Routes.navigateTo(context, Routes.videoCallScreen);
        },
        child: const Text(
          'Add a rating',
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 18),
            SizedBox(width: 6),
            Text('Monday, 31 Oct 2023', style: CustomTextStyle.bodyRegular),
            SizedBox(width: 20),
            Icon(Icons.access_time_outlined, size: 18),
            SizedBox(width: 6),
            Text('10:00 - 10:15 AM', style: CustomTextStyle.bodyRegular),
          ],
        ));
  }

  _requestForLesson(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // _showEditRequestButton(context),
            Icon(
              Icons.request_page_outlined,
              size: 18,
            ),
            SizedBox(width: 6),
            Expanded(
                child: Row(
              children: [
                Text('Requests:', style: CustomTextStyle.bodyRegular),
                SizedBox(width: 6),
                Text('No request for lesson',
                    style: CustomTextStyle.bodyRegular),
              ],
            )),
          ],
        ));
  }

  _reviewFromTutor() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.rate_review_outlined,
                  size: 18,
                ),
                SizedBox(width: 6),
                Expanded(
                    child: Row(
                  children: [
                    Text('Review from tutor:',
                        style: CustomTextStyle.bodyRegular),
                  ],
                )),

                // Expanded button
                IconButton(
                    onPressed: () {
                      setState(() {
                        isReviewExpanded = !isReviewExpanded;
                      });
                    },
                    icon: Icon(
                      isReviewExpanded
                          ? Icons.arrow_drop_down_sharp
                          : Icons.arrow_right_sharp,
                      size: 38,
                      color: Theme.of(context).primaryColor,
                    ))
              ],
            ),
            // review content
            Visibility(
                visible: isReviewExpanded,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Text(
                        'Session 1: 00:00 - 00:25\nLesson status: Completed\nLesson: The Internet\nBehavior (⭐⭐⭐⭐⭐):\nListening (⭐⭐⭐⭐):\nSpeaking (⭐⭐⭐):\nVocabulary (⭐⭐⭐⭐⭐):\nOverall comment: Good and handsome.')))
          ],
        ));
  }
}

Future<bool> showEditRequestDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Requests For Lesson'),
        content: TextField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(28),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10))),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
