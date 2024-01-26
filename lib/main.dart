import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/presentation/screen/authentication/sign_in_screen.dart';
import 'package:let_tutor/presentation/styles/theme.dart';
import 'package:provider/provider.dart';
import 'package:let_tutor/routes.dart';
import 'package:let_tutor/blocs/auth/auth_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.readCountriesFromJson();
  log(AppConfig.countries.length.toString());
  await EasyLocalization.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppTheme(),
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildAuthRepositories(),
      child: Consumer<AppTheme>(
        builder: (_, themeProvider, __) => MaterialApp(
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
          darkTheme: ThemeData.dark(),
          themeMode: AppTheme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          onGenerateRoute: Routes.generateRoute,
          home: MultiBlocProvider(
            providers: buildAuthBlocs(context),
            child: const SignInScreen(),
          ),
        ),
      ),
    );
  }
}
