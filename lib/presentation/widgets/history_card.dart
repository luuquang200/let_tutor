import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/routes.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({super.key});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool isReviewExpanded = false;
  bool isRequestExpanded = false;

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
                _tutorAvatar(context, 44),
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

  void _showReportDialog(BuildContext context) {
    final textController =
        TextEditingController(); // controller để lấy giá trị của TextField
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
                _tutorAvatar(context, 32),
                const SizedBox(width: 16),
                Column(
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
            Text('What was the reason you reported on the lesson?',
                style: CustomTextStyle.bodyRegular),
            const SizedBox(height: 8),
            TextField(
              controller: textController,
              decoration: InputDecoration(
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

  _tutorInfo(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Routes.navigateTo(context, Routes.tutorDetail);
            },
            child: Text(
              'Krystal',
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

  Widget _tutorAvatar(BuildContext context, double radius) {
    return GestureDetector(
      onTap: () {
        Routes.navigateTo(context, Routes.tutorDetail);
      },
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/tutor_avatar_01.jpg'),
        radius: radius,
      ),
    );
  }

  _reportButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.red),
        onPressed: () {
          _showReportDialog(context);
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

  _timeInfo() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 18),
            SizedBox(width: 6),
            Text('Monday, 31 Oct 2023', style: CustomTextStyle.bodyRegular),
            SizedBox(width: 20),
            Icon(Icons.access_time_outlined, size: 18),
            SizedBox(width: 2),
            Text('10:00 - 10:15 AM', style: CustomTextStyle.bodyRegular),
          ],
        ));
  }

  _requestForLesson(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.request_page_outlined,
                  size: 18,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Row(
                    children: [
                      Text('Requests for lesson:',
                          style: CustomTextStyle.bodyRegular),
                      SizedBox(width: 6),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isRequestExpanded = !isRequestExpanded;
                      });
                    },
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isRequestExpanded
                          ? Icons.arrow_drop_down_sharp
                          : Icons.arrow_right_sharp,
                      size: 38,
                      color: Theme.of(context).primaryColor,
                    )),
              ],
            ),
            Visibility(
                visible: isRequestExpanded,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Text(
                      'Hi there! I\'d like to schedule a tutoring session to cover grammarly. Do you have any specific materials or resources I should prepare for the session?'),
                ))
          ],
        ));
  }

  _reviewFromTutor() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    padding: EdgeInsets.zero,
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
