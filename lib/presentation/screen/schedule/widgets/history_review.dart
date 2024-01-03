import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class HistoryReview extends StatefulWidget {
  const HistoryReview({super.key, this.review});
  final String? review;

  @override
  State<HistoryReview> createState() => _HistoryReviewState();
}

class _HistoryReviewState extends State<HistoryReview> {
  bool isReviewExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.rate_review_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Expanded(
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
                    padding: const EdgeInsets.only(left: 28, right: 8),
                    child: Text(
                      widget.review ?? "Tutor haven't reviewed yet",
                    )))
          ],
        ));
  }
}
