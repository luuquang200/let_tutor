import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/screen/schedule/widgets/booked_schedule_tab.dart';
import 'package:let_tutor/presentation/screen/schedule/widgets/history_schedule_tab.dart';
import 'package:let_tutor/presentation/styles/theme.dart';

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
            const Expanded(
              child: TabBarView(
                  children: [BookedScheduleTab(), HistoryScheduleTab()]),
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
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            'my_schedule'.tr(),
            style: TextStyle(color: AppTheme.primaryColor),
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
          Icon(Icons.history_outlined, color: AppTheme.primaryColor),
          const SizedBox(width: 8),
          Text(
            'history'.tr(),
            style: TextStyle(color: AppTheme.primaryColor),
          )
        ],
      ),
    );
  }
}
