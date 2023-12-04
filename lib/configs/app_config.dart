import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:let_tutor/data/models/country.dart';

class AppConfig {
  AppConfig._();

  static List<Country> _countries = [];
  static List<Country> get countries => _countries;

  static Future<void> readCountriesFromJson() async {
    final String jsonString =
        await rootBundle.loadString('assets/jsons/countries.json');
    final List<dynamic> jsonCountries = jsonDecode(jsonString);
    _countries = jsonCountries.map((json) => Country.fromJson(json)).toList();
  }

  // get flag url from country code
  static String getFlagUrl(String code) {
    final country = _countries.firstWhere((country) => country.code == code,
        orElse: () => Country(name: 'Unknown', code: 'Unknown'));
    String codeName = country.code.toLowerCase();
    return 'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/${codeName}.svg';
  }
}
