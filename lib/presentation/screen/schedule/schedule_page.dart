import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/schedule/schedule_bloc.dart';
import 'package:let_tutor/blocs/schedule/schedule_state.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/schedule/booking.dart';
import 'package:let_tutor/presentation/widgets/booked_schedule_card.dart';
import 'package:let_tutor/presentation/widgets/history_card.dart';
import 'package:let_tutor/routes.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:collection/collection.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              _bookedScheduleTabHeadline(),
              _historyTabHeadline(),
            ]),
            Expanded(
              child: TabBarView(children: [BookedScheduleTab(), _historyTab()]),
            )
          ],
        ));
  }

  _bookedScheduleTabHeadline() {
    return Tab(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            'My schedule',
            style: TextStyle(color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }

  _historyTabHeadline() {
    return Tab(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_outlined,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            'History',
            style: TextStyle(color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }

  // _bookedScheduleTab() {
  //   return Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //       child: ListView.builder(
  //         shrinkWrap: true,
  //         scrollDirection: Axis.vertical,
  //         itemCount: 10,
  //         itemBuilder: (context, index) {
  //           return GestureDetector(
  //             onTap: () {
  //               Routes.navigateTo(context, Routes.courseDetail);
  //             },
  //             child: const BookedScheduleCard(),
  //           );
  //         },
  //       ));
  // }

  _historyTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: const HistoryCard(),
                );
              },
            ),
            NumberPaginator(
              numberPages: 8,
              onPageChange: (index) {
                log('index, $index');
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
          if (state.schedules.isEmpty) {
            return const Center(
              child: Text('No schedule found'),
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
