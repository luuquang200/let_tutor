import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/screen/booking_screen.dart';
import 'package:let_tutor/presentation/screen/course_detail.dart';
import 'package:let_tutor/presentation/screen/courses_screen.dart';
import 'package:let_tutor/presentation/screen/home.dart';
import 'package:let_tutor/presentation/screen/schedule_screen.dart';
import 'package:let_tutor/presentation/screen/sign_in_screen.dart';
import 'package:let_tutor/presentation/screen/topic_detail.dart';
import 'package:let_tutor/presentation/screen/tutor_detail.dart';
import 'package:let_tutor/presentation/screen/tutor_list_screen.dart';
import 'package:let_tutor/presentation/screen/tutor_review_screen.dart';
import 'package:let_tutor/presentation/screen/video_call_screen.dart';
import 'package:let_tutor/presentation/screen/write_review.dart';

class Routes {
  static const String signInScreen = '/sign_in_screen';
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

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case tutorListScreen:
        return MaterialPageRoute(builder: (_) => const TutorListScreen());
      case tutorDetail:
        return MaterialPageRoute(builder: (_) => const TutorDetail());
      case bookingScreen:
        return MaterialPageRoute(builder: (_) => const BookingScreen());
      case tutorReviewScreen:
        return MaterialPageRoute(builder: (_) => const TutorReviewScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      case coursesScreen:
        return MaterialPageRoute(builder: (_) => const CoursesScreen());
      case courseDetail:
        return MaterialPageRoute(builder: (_) => const CourseDetail());
      case topicDetail:
        return MaterialPageRoute(builder: (_) => const TopicDetail());
      case scheduleScreen:
        return MaterialPageRoute(builder: (_) => const ScheduleSceen());
      case videoCallScreen:
        return MaterialPageRoute(builder: (_) => const VideoCallScreen());
      case writeReview:
        return MaterialPageRoute(builder: (_) => const WriteReview());
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
