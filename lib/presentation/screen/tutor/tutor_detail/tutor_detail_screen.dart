import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_event.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_detail/tutor_detail_page.dart';

class TutorDetailScreen extends StatefulWidget {
  final String tutorId;

  const TutorDetailScreen({Key? key, required this.tutorId}) : super(key: key);
  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TutorDetailBloc(tutorRepository: TutorRepository())
        ..add(TutorDetailRequested(tutorId: widget.tutorId)),
      child: TutorDetailPage(tutorId: widget.tutorId),
    );
  }
}
