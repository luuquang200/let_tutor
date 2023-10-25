import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/booking_screen.dart';
import 'package:let_tutor/presentation/sign_in_screen.dart';
import 'package:let_tutor/presentation/tutor_detail.dart';
import 'package:let_tutor/presentation/tutor_list_screen.dart';

class Routes {
  static const String signInScreen = '/sign_in_screen';
  static const String tutorListScreen = '/tutor_list_screen';
  static const String tutorDetail = '/tutor_detail';
  static const String bookingScreen = '/booking_screen';

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
