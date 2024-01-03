import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/schedule/booked_schedule/schedule_bloc.dart';
import 'package:let_tutor/blocs/schedule/booked_schedule/schedule_event.dart';
import 'package:let_tutor/blocs/schedule/history_schedule/history_schedule_bloc.dart';
import 'package:let_tutor/blocs/schedule/history_schedule/history_schedule_event.dart';
import 'package:let_tutor/data/repositories/schedule_repository.dart';
import 'package:let_tutor/presentation/screen/schedule/schedule_page.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScheduleBloc>(
          create: (context) => ScheduleBloc(
            scheduleRepository: ScheduleRepository(),
          )..add(const GetScheduleList()),
        ),
        BlocProvider<HistoryScheduleBloc>(
          create: (context) => HistoryScheduleBloc(
            scheduleRepository: ScheduleRepository(),
          )..add(const GetHistoryScheduleList(page: 1)),
        ),
      ],
      child: const SchedulePage(),
    );
  }
}
