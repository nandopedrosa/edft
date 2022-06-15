// ignore_for_file: avoid_print

import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../localization/localization_service.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar:
            const MyBottomNavigationBar(currentPage: aboutPageIndex),
        appBar: AppBar(
          titleTextStyle: appBarTitle,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            LocalizationService.instance.getLocalizedString("about"),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    LocalizationService.instance
                        .getLocalizedString("app_title"),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    LocalizationService.instance
                        .getLocalizedString("about_app"),
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    LocalizationService.instance
                        .getLocalizedString("questions_suggestions_contact"),
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "marcosmelo@gmail.com",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            )),
      ),
    );
  }
}
