import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_bloc.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_event.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';
import 'package:let_tutor/presentation/screen/tutor/booking/booking_page.dart';

class BookingScreen extends StatefulWidget {
  final String tutorId;

  const BookingScreen({Key? key, required this.tutorId}) : super(key: key);
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(tutorRepository: TutorRepository())
        ..add(BookingInitialRequested(tutorId: widget.tutorId)),
      child: BookingPage(tutorId: widget.tutorId),
    );
  }
}
