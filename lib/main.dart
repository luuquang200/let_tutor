import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/presentation/screen/authentication/sign_in_screen.dart';
import 'package:let_tutor/routes.dart';
import 'package:let_tutor/app_providers.dart';
//

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.readCountriesFromJson();
  log(AppConfig.countries.length.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MaterialApp(
        title: 'LetTutor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0058C6),
            secondary: Colors.blueAccent,
          ),
          useMaterial3: true,
        ),
        onGenerateRoute: Routes.generateRoute,
        home: MultiBlocProvider(
          providers: buildBlocs(context),
          child: const SignInScreen(),
        ),
      ),
    );
  }
}
