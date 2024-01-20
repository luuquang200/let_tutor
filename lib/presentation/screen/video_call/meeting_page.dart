import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/meeting/meeting_bloc.dart';

class MeetingPage extends StatefulWidget {
  final String link;

  const MeetingPage({super.key, required this.link});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MeetingBloc()
        ..add(
          CreateMeetingEvent(widget.link),
        ),
      child: BlocConsumer<MeetingBloc, MeetingState>(
        listener: (context, state) {
          if (state is MeetingError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is MeetingLeft) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is MeetingError) {
            return Text(state.message);
          }
          return Container();
        },
      ),
    );
  }
}
