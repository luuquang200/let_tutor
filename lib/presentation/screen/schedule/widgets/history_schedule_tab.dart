import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/schedule/history_schedule/history_schedule_bloc.dart';
import 'package:let_tutor/blocs/schedule/history_schedule/history_schedule_event.dart';
import 'package:let_tutor/blocs/schedule/history_schedule/history_schedule_state.dart';
import 'package:let_tutor/presentation/screen/schedule/widgets/history_card.dart';
import 'package:number_paginator/number_paginator.dart';

class HistoryScheduleTab extends StatefulWidget {
  const HistoryScheduleTab({super.key});

  @override
  State<HistoryScheduleTab> createState() => _HistoryScheduleTabState();
}

class _HistoryScheduleTabState extends State<HistoryScheduleTab> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryScheduleBloc, HistoryScheduleState>(
      listener: (context, state) {
        if (state is HistoryScheduleLoadFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is HistoryScheduleLoading) {
          return const Center(
            widthFactor: 1,
            child: CircularProgressIndicator(),
          );
        } else if (state is HistoryScheduleLoadSuccess) {
          if (state.schedules.isEmpty) {
            return const Center(
              child: Text('You have no schedule'),
            );
          }

          var historySchedules = state.schedules;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: historySchedules.length,
                    itemBuilder: (context, index) {
                      return HistoryCard(
                        bookedSchedule: historySchedules[index],
                      );
                    },
                  ),
                  NumberPaginator(
                    numberPages: state.totalPage,
                    initialPage: state.page - 1,
                    onPageChange: (index) {
                      log('index, $index');
                      context
                          .read<HistoryScheduleBloc>()
                          .add(GetHistoryScheduleList(page: index + 1));
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
