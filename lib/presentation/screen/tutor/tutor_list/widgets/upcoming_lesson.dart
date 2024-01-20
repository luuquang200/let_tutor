import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:let_tutor/data/sharedpref/shared_preference_helper.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpcomingLesson extends StatefulWidget {
  const UpcomingLesson({super.key});
  @override
  State<UpcomingLesson> createState() => _UpcomingLessonState();
}

class _UpcomingLessonState extends State<UpcomingLesson> {
  String? locale;

  @override
  void initState() {
    loadLocale();
    super.initState();
  }

  Future<void> loadLocale() async {
    locale = await getLocale();
    log('locale: $locale');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 250,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<TutorListBloc, TutorListState>(
            buildWhen: (previousState, currentState) {
              if (currentState is TutorListSuccess) {
                if (previousState is TutorListSuccess) {
                  return previousState.upcomingSchedule.id !=
                      currentState.upcomingSchedule.id;
                }
                // This is the first time emitting TutorListSuccess
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is TutorListSuccess) {
                if (state.upcomingSchedule.id != null) {
                  final upcomingSchedule = state.upcomingSchedule;
                  final startTime = DateTime.fromMillisecondsSinceEpoch(
                      upcomingSchedule
                              .scheduleDetailInfo?.startPeriodTimestamp ??
                          0);
                  final endTime = DateTime.fromMillisecondsSinceEpoch(
                      upcomingSchedule.scheduleDetailInfo?.endPeriodTimestamp ??
                          0);

                  return Column(
                    children: [
                      const Text(
                        'Upcoming lesson',
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.headlineLargeWhite,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${DateFormat('EEE, dd MMM yy', locale).format(startTime)} ${DateFormat('HH:mm', locale).format(startTime)} - ${DateFormat('HH:mm', locale).format(endTime)}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          StreamBuilder<int>(
                            stream: Stream.periodic(
                                const Duration(seconds: 1), (i) => i),
                            builder: (context, snapshot) {
                              final countdownDuration =
                                  startTime.difference(DateTime.now());
                              final countdownString =
                                  '${countdownDuration.inHours}:${(countdownDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(countdownDuration.inSeconds % 60).toString().padLeft(2, '0')}';
                              return Text(
                                '(starts in $countdownString)',
                                style: CustomTextStyle.timer,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.meetingPage,
                              arguments: upcomingSchedule.studentMeetingLink);
                        },
                        label: const Text("Enter lesson room"),
                        icon: const Icon(Icons.play_circle_fill_outlined),
                      ),
                    ],
                  );
                } else {
                  return const Text(
                    'You have no upcoming lesson.',
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.headlineLargeWhite,
                  );
                }
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<TutorListBloc, TutorListState>(
            buildWhen: (previousState, currentState) {
              if (currentState is TutorListSuccess) {
                if (previousState is TutorListSuccess) {
                  return previousState.totalCall != currentState.totalCall;
                }
                // This is the first time emitting TutorListSuccess
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is TutorListSuccess) {
                final hours = state.totalCall ~/ 60;
                final minutes = state.totalCall % 60;
                return Text(
                  'Total lesson time is $hours hours $minutes minutes',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                );
              }
              // Return an empty Container when state is not TutorListSuccess
              return Container();
            },
          )
        ],
      ),
    );
  }

  Future<String?> getLocale() async {
    SharedPreferenceHelper sharedPreferences =
        SharedPreferenceHelper(await SharedPreferences.getInstance());
    return sharedPreferences.locale;
  }
}
