// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'localization_strings.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class LocalizationService {
  //Private constructor
  LocalizationService._();
  //Singleton implementation
  static final LocalizationService instance = LocalizationService._();

  String _preferredLanguage = '';
  String getPreferredLanguage() {
    if (_preferredLanguage == '') {
      String currentSystemLocale =
          Platform.localeName; // Returns locale string in the form 'en_US'
      if (currentSystemLocale.startsWith('pt')) {
        _preferredLanguage = 'pt';
      } else {
        _preferredLanguage = 'en';
      }
    }
    return _preferredLanguage;
  }

  //Only Portuguese supported at this time
  String getLocalizedString(String key) {
    // Portuguese - index 0 , English - index 1
    // We use these indexes to fetch values from associative map
    int index = getPreferredLanguage() == 'pt' ? 0 : 1;
    String localizedString = LocalizationStrings.localizedStrings[key]![index];
    return localizedString;
  }

  //Param: ISO8601 formatted date (YYYY-MM-DD HH:MM)
  //Return: 01/01/1996:
  String? getFullLocalizedDateAndTime(String? iso8601Date) {
    String platformLocaleName = Platform.localeName;
    initializeDateFormatting(platformLocaleName, null);
    var parsedDate = DateTime.parse(iso8601Date!);
    var formatter = DateFormat.yMd(platformLocaleName);
    String result = formatter.format(parsedDate);
    return result;
  }
}
