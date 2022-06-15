// ignore_for_file: avoid_print

import 'package:edft/screens/home_screen.dart';
import 'package:edft/screens/profile_screen.dart';
import 'package:edft/screens/about_screen.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
