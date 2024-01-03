import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/schedule/booked_schedule/schedule_bloc.dart';
import 'package:let_tutor/blocs/schedule/booked_schedule/schedule_state.dart';
import 'package:let_tutor/presentation/screen/schedule/widgets/booked_schedule_card.dart';

class BookedScheduleTab extends StatelessWidget {
  const BookedScheduleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      listener: (context, state) {
        if (state is ScheduleLoadFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        }
        if (state is ScheduleLoadSuccess && state.isCancelSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Row(
                  children: <Widget>[
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8.0),
                    Text('Cancel schedule success !'),
                  ],
                ),
                backgroundColor: Colors.green,
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is ScheduleLoading) {
          return const Center(
            widthFactor: 1,
            child: CircularProgressIndicator(),
          );
        } else if (state is ScheduleLoadSuccess) {
          log('load success ${state.schedules.length}');
          if (state.schedules.isEmpty || state.schedules.first.isEmpty) {
            return const Center(
              child: Text('You have no schedule'),
            );
          }

          var groupedSchedules = state.schedules;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: groupedSchedules.length,
              itemBuilder: (context, index) {
                return BookedScheduleCard(
                  bookedSchedules: groupedSchedules[index],
                );
              },
            ),
          );
        } else if (state is ScheduleLoadFailure) {
          return Text('Error: ${state.message}');
        } else {
          return const Text('Please click the button to load the schedules');
        }
      },
    );
  }
}
