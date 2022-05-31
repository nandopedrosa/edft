// ignore_for_file: prefer_final_fields

import 'localization_strings.dart';

class LocalizationService {
  //Private constructor
  LocalizationService._();
  //Singleton implementation
  static final LocalizationService instance = LocalizationService._();

  String _preferredLanguage = '';
  String getPreferredLanguage() {
    return _preferredLanguage;
  }

  //Only Portuguese supported at this time
  String getLocalizedString(String key) {
    //TODO: Implement Preferred Language detection (intl package)
    if (_preferredLanguage == '') {
      _preferredLanguage = 'pt';
    }

    // Portuguese - index 0 , English - index 1
    // We use these indexes to fetch values from associative map
    int index = _preferredLanguage == 'pt' ? 0 : 1;
    String localizedString = LocalizationStrings.localizedStrings[key]![index];
    return localizedString;
  }
}
