import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/schedule/booked_schedule/schedule_bloc.dart';
import 'package:let_tutor/blocs/schedule/history_schedule/history_schedule_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:let_tutor/blocs/auth/sign_up/sign_up_bloc.dart';
import 'package:let_tutor/blocs/tutor/booking/booking_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_bloc.dart';
import 'package:let_tutor/data/repositories/authentication_repository.dart';
import 'package:let_tutor/data/repositories/schedule_repository.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';
import 'package:let_tutor/data/repositories/user_repository.dart';
import 'package:let_tutor/data/sharedpref/shared_preference_helper.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_detail/tutor_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<RepositoryProvider> buildAuthRepositories() {
  return [
    RepositoryProvider<AuthenticationRepository>(
      create: (context) => AuthenticationRepository(),
    ),
  ];
}

List<BlocProvider> buildAuthBlocs(BuildContext context) {
  return [
    BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
    ),
    BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
    ),
    // // tutor bloc
    // BlocProvider<TutorListBloc>(
    //   create: (context) => TutorListBloc(
    //     tutorRepository: context.read<TutorRepository>(),
    //     scheduleRepository: context.read<ScheduleRepository>(),
    //     userRepository: context.read<UserRepository>(),
    //   ),
    // ),
    // // tutor detail bloc
    // BlocProvider<TutorDetailBloc>(
    //   create: (context) => TutorDetailBloc(
    //     tutorRepository: context.read<TutorRepository>(),
    //   ),
    // ),
    // // booking bloc
    // BlocProvider<BookingBloc>(
    //   create: (context) => BookingBloc(
    //     tutorRepository: context.read<TutorRepository>(),
    //   ),
    // ),
    // // schedule bloc
    // BlocProvider<ScheduleBloc>(
    //   create: (context) => ScheduleBloc(
    //     scheduleRepository: context.read<ScheduleRepository>(),
    //   ),
    // ),
    // // history schedule bloc
    // BlocProvider<HistoryScheduleBloc>(
    //   create: (context) => HistoryScheduleBloc(
    //     scheduleRepository: context.read<ScheduleRepository>(),
    //   ),
    // ),

    // Add more blocs here
  ];
}
