import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/widgets/booked_schedule_card.dart';
import 'package:let_tutor/presentation/widgets/course_card.dart';
import 'package:let_tutor/presentation/widgets/history_card.dart';
import 'package:let_tutor/routes.dart';

class ScheduleSceen extends StatefulWidget {
  const ScheduleSceen({super.key});

  @override
  State<ScheduleSceen> createState() => _ScheduleSceenState();
}

class _ScheduleSceenState extends State<ScheduleSceen> {
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
              child:
                  TabBarView(children: [_bookedScheduleTab(), _historyTab()]),
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

  _bookedScheduleTab() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Routes.navigateTo(context, Routes.courseDetail);
              },
              child: const BookedScheduleCard(),
            );
          },
        ));
  }

  _historyTab() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Routes.navigateTo(context, Routes.courseDetail);
              },
              child: const HistoryCard(),
            );
          },
        ));
  }
}
