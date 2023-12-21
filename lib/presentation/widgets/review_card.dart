import 'package:flutter/material.dart';
import 'package:let_tutor/data/models/tutors/feedback.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/star_rating.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewCard extends StatelessWidget {
  final TutorFeedback feedback;
  const ReviewCard({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Column(
          children: [
            Row(
              children: [
                TutorAvatar(
                    imageUrl: feedback.firstInfo?.avatar ?? '',
                    tutorName: feedback.firstInfo?.name ?? '',
                    radius: 35),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(feedback.firstInfo?.name ?? '',
                        style: CustomTextStyle.headlineLarge),
                    Text(_getTimeAgo(feedback.createdAt)),
                    _StarRating(rating: feedback.rating ?? 0, size: 20),
                    const SizedBox(height: 8),
                    Text(feedback.content ?? '',
                        style: CustomTextStyle.bodyRegular),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(String? createdAt) {
    if (createdAt == null) {
      return '';
    }

    final dateTime = DateTime.parse(createdAt);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    return timeago.format(now.subtract(difference));
  }
}

class _StarRating extends StatelessWidget {
  final int rating;
  final double size;

  const _StarRating({Key? key, required this.rating, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rating == 0) {
      return const Text('No reviews yet');
    } else {
      return Row(
        children: List<Widget>.generate(
          5,
          (index) => Icon(
            Icons.star,
            color: index < rating ? Colors.amber : Colors.grey,
            size: size,
          ),
        ),
      );
    }
  }
}
