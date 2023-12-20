import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/feedback/feedback_bloc.dart';
import 'package:let_tutor/blocs/tutor/feedback/feedback_event.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';
import 'package:let_tutor/presentation/screen/tutor/review/tutor_review_page.dart';

class TutorReviewScreen extends StatefulWidget {
  final String tutorId;

  const TutorReviewScreen({Key? key, required this.tutorId}) : super(key: key);
  @override
  State<TutorReviewScreen> createState() => _TutorReviewScreenState();
}

class _TutorReviewScreenState extends State<TutorReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackBloc(tutorRepository: TutorRepository())
        ..add(FeedbackRequested(tutorId: widget.tutorId)),
      child: ReviewPage(tutorId: widget.tutorId),
    );
  }
}
