import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/screen/sign_in_screen.dart';
import 'package:let_tutor/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetTutor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0058C6),
          secondary: Colors.blueAccent,
        ),
        // iconTheme: IconThemeData(color: Color(0xFF0058C6)),
        useMaterial3: true,
      ),
      onGenerateRoute: Routes.generateRoute,
      home: const SignInScreen(),
    );
  }
}
