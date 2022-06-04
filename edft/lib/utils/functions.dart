// ignore_for_file: avoid_print

import 'package:edft/screens/home_screen.dart';
import 'package:edft/screens/places_screen.dart';
import 'package:edft/screens/profile_screen.dart';
import 'package:edft/screens/settings_screen.dart';
import 'package:edft/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
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

    case placesPageIndex:
      {
        w = const PlacesScreen();
      }
      break;

    case profilePageIndex:
      {
        w = const ProfileScreen();
      }
      break;

    case settingsPageIndex:
      {
        w = const SettingsScreen();
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
