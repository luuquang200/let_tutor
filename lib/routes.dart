import 'package:flutter/material.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/course/topic.dart';
import 'package:let_tutor/data/models/schedule/booked_schedule.dart';
import 'package:let_tutor/presentation/screen/account/profile_setting_screen.dart';
import 'package:let_tutor/presentation/screen/authentication/sign_up_screen.dart';
import 'package:let_tutor/presentation/screen/courses/course_detail.dart';
import 'package:let_tutor/presentation/screen/courses/courses_screen.dart';
import 'package:let_tutor/presentation/screen/home.dart';
import 'package:let_tutor/presentation/screen/authentication/sign_in_screen.dart';
import 'package:let_tutor/presentation/screen/courses/topic_detail.dart';
import 'package:let_tutor/presentation/screen/setting/setting_page.dart';
import 'package:let_tutor/presentation/screen/video_call/meeting_page.dart';
import 'package:let_tutor/presentation/screen/schedule/schedule_screen.dart';
import 'package:let_tutor/presentation/screen/tutor/booking/booking_screen.dart';
import 'package:let_tutor/presentation/screen/tutor/review/tutor_review_screen.dart';

import 'package:let_tutor/presentation/screen/tutor/tutor_detail/tutor_detail_screen.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_list/tutor_list_screen.dart';
import 'package:let_tutor/presentation/screen/video_call/video_call_screen.dart';
import 'package:let_tutor/presentation/screen/schedule/write_review.dart';
import 'package:let_tutor/presentation/screen/authentication/forgot_password_screen.dart';

class Routes {
  static const String signInScreen = '/sign_in_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String tutorListScreen = '/tutor_list_screen';
  static const String tutorDetail = '/tutor_detail';
  static const String bookingScreen = '/booking_screen';
  static const String tutorReviewScreen = '/tutor_review_screen';
  static const String home = '/home';
  static const String coursesScreen = '/courses_screen';
  static const String courseDetail = '/course_detail';
  static const String topicDetail = '/topic_detail';
  static const String scheduleScreen = '/schedule_screen';
  static const String videoCallScreen = '/video_call_screen';
  static const String writeReview = '/write_review';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String profileSettingScreen = '/profile_setting_screen';
  static const String meetingPage = '/meeting_page';
  static const String settingsPage = '/settings_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case tutorListScreen:
        return MaterialPageRoute(builder: (_) => const TutorListScreen());
      case tutorDetail:
        return MaterialPageRoute(
            builder: (_) =>
                TutorDetailScreen(tutorId: settings.arguments as String));
      case bookingScreen:
        return MaterialPageRoute(
            builder: (_) =>
                BookingScreen(tutorId: settings.arguments as String));
      case tutorReviewScreen:
        return MaterialPageRoute(
            builder: (_) =>
                TutorReviewScreen(tutorId: settings.arguments as String));
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      case coursesScreen:
        return MaterialPageRoute(builder: (_) => const CoursesScreen());
      case courseDetail:
        return MaterialPageRoute(
            builder: (_) =>
                CourseDetail(courseId: settings.arguments as String));
      case topicDetail:
        return MaterialPageRoute(
            builder: (_) => TopicDetail(topic: settings.arguments as Topic));
      case scheduleScreen:
        return MaterialPageRoute(builder: (_) => const ScheduleScreen());
      case videoCallScreen:
        return MaterialPageRoute(
            builder: (_) => WaitingCallScreen(
                bookedSchedule: settings.arguments as BookedSchedule));
      case writeReview:
        return MaterialPageRoute(builder: (_) => const WriteReview());
      case profileSettingScreen:
        return MaterialPageRoute(builder: (_) => const ProfileSettingScreen());
      case meetingPage:
        return MaterialPageRoute(
            builder: (_) => MeetingPage(link: settings.arguments as String));
      case settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      default:
        return MaterialPageRoute(builder: (_) => const UnknownScreen());
    }
  }

  static Future<void> navigateTo(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  static Future<void> navigateToReplacement(
      BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed(context, routeName);
  }

  static Future<void> navigateToAndRemoveUntil(
      BuildContext context, String routeName) {
    return Navigator.pushNamedAndRemoveUntil(
        context, routeName, (route) => false);
  }
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknown Screen'),
      ),
      body: const Center(
        child: Text('Unknown Screen'),
      ),
    );
  }
}
