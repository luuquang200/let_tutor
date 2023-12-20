import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/feedback/feedback_bloc.dart';
import 'package:let_tutor/blocs/tutor/feedback/feedback_state.dart';
import 'package:let_tutor/data/models/tutors/feedback.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/review_card.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key, required this.tutorId}) : super(key: key);
  final String tutorId;
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<TutorFeedback> feedbacks = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tutor Review',
            style: CustomTextStyle.topHeadline,
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<FeedbackBloc, FeedbackState>(
              builder: (context, state) {
                if (state is FeedbackLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FeedbackSuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.feedbacks.length,
                    itemBuilder: (context, index) {
                      return ReviewCard(feedback: state.feedbacks[index]);
                    },
                  );
                } else if (state is FeedbackFailure) {
                  return Text('Error: ${state.error}');
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
