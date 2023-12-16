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
  // get flag url from country code
  static Future<String> getFlagUrl(String code) async {
    Country country = _countries.firstWhere(
      (country) => country.code == code,
      orElse: () => _countries.firstWhere(
        (country) => country.name == code,
        orElse: () => Country(name: 'Unknown', code: 'Unknown'),
      ),
    );

    // If the input code is equal to the country name, swap them
    if (country.name == code) {
      return 'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/${country.code.toLowerCase()}.svg';
    }

    if (country.code == 'Unknown') {
      return 'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/saint martin.svg';
    }

    String codeName = country.code.toLowerCase();
    return 'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/${codeName}.svg';
  }
}
