import 'dart:async';

import 'package:let_tutor/data/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get accessToken async {
    return _sharedPreference.getString(Preferences.access_token);
  }

  Future<String?> get refreshToken async {
    return _sharedPreference.getString(Preferences.refresh_token);
  }

  Future<bool> saveAcessToken(String accessToken) async {
    return _sharedPreference.setString(Preferences.access_token, accessToken);
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    return _sharedPreference.setString(Preferences.refresh_token, refreshToken);
  }

  Future<bool> removeAcessToke() async {
    return _sharedPreference.remove(Preferences.access_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }

  Future<void> saveUser(User user) {
    return _sharedPreference.setString(Preferences.user_id, user.id!);
  }

  Future<String?> get userId async {
    return _sharedPreference.getString(Preferences.user_id);
  }
}
