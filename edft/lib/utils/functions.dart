// ignore_for_file: avoid_print

import 'package:edft/localization/localization_service.dart';
import 'package:edft/screens/home_screen.dart';
import 'package:edft/screens/profile_screen.dart';
import 'package:edft/screens/about_screen.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' show cos, sqrt, asin;

// for displaying snackbars
showSnackBar(BuildContext context, String text, String type) {
  TextStyle style = const TextStyle();
  if (type == 'success') {
    style = const TextStyle(color: successColor);
  } else if (type == 'warning') {
    style = const TextStyle(color: warningColor);
  } else if (type == 'error') {
    style = const TextStyle(color: errorColor);
  }
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: style,
      ),
    ),
  );
}

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  print('No Image Selected');
}

Widget pickPage(int page) {
  Widget w;

  switch (page) {
    case homePageIndex:
      {
        w = const HomeScreen();
      }
      break;

    case profilePageIndex:
      {
        w = const ProfileScreen();
      }
      break;

    case aboutPageIndex:
      {
        w = const AboutScreen();
      }
      break;

    default:
      {
        w = const HomeScreen();
      }
      break;
  }
  return w;
}

Country? getCountryFromCode(String? code) {
  if (code == null || code.isEmpty) {
    return null;
  }
  String lang = LocalizationService.instance.getPreferredLanguage();
  List<Country> listOfCountries = [];
  if (lang == 'pt') {
    listOfCountries = countriesPt;
  } else {
    listOfCountries = countriesEn;
  }
  for (Country country in listOfCountries) {
    if (country.code == code) {
      return country;
    }
  }
  return null;
}

//Calculate distance between two points based on Latitude and Longitude
// Returns distance in KM
double calculateDistance({
  required double lat1,
  required double lng1,
  required double lat2,
  required double lng2,
}) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

//Returns the budget threshold value
int getBudgetThreshold(String? budgetPreference) {
  int res = 99; //any attraction

  if (budgetPreference == null || budgetPreference.isEmpty) {
    return res;
  }

  if (budgetPreference == "economic") {
    res = economicBudgetThreshold;
  } else if (budgetPreference == "executive") {
    res = executiveBudgetThreshold;
  } else {
    res = -1;
  }

  return res;
}
