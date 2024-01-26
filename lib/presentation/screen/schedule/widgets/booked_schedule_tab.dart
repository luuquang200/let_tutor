import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
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
              SnackBar(
                content: Row(
                  children: <Widget>[
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 8.0),
                    Text('cancel_schedule_success'.tr()),
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
            return Center(
              child: Text('no_schedule'.tr()),
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
          return Text('${'error'.tr()}: ${state.message}');
        }
        return Container();
      },
    );
  }
}
