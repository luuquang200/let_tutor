import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/presentation/screen/authentication/sign_in_screen.dart';
import 'package:let_tutor/routes.dart';
import 'package:let_tutor/blocs/auth/auth_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.readCountriesFromJson();
  log(AppConfig.countries.length.toString());
  await EasyLocalization.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildAuthRepositories(),
      child: MaterialApp(
        title: 'LetTutor',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
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
          providers: buildAuthBlocs(context),
          child: const SignInScreen(),
        ),
      ),
    );
  }
}
