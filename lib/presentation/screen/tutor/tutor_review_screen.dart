import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/review_card.dart';

class TutorReviewScreen extends StatefulWidget {
  const TutorReviewScreen({Key? key}) : super(key: key);

  @override
  State<TutorReviewScreen> createState() => _TutorReviewScreenState();
}

class _TutorReviewScreenState extends State<TutorReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Tutor Review',
              style: CustomTextStyle.topHeadline,
            ),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ReviewCard();
                },
              )),
        ),
      ),
    );
  }
}