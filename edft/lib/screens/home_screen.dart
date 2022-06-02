// ignore_for_file: avoid_print

import 'package:edft/screens/login_screen.dart';
import 'package:edft/utils/styles.dart';
import 'package:flutter/material.dart';

import '../localization/localization_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: appBarTitle,
          automaticallyImplyLeading: false,
          title: Text(
            LocalizationService.instance.getLocalizedString("my_trips"),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(), // TODO: implementar os cards aqui
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
    );
  }
}
