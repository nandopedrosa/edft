// ignore_for_file: avoid_print

import 'package:edft/screens/login_screen.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/styles.dart';
import 'package:flutter/material.dart';

import '../localization/localization_service.dart';

class PasswordResetEmailSentScreen extends StatefulWidget {
  const PasswordResetEmailSentScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetEmailSentScreen> createState() =>
      PasswordResetEmailSentScreenState();
}

class PasswordResetEmailSentScreenState
    extends State<PasswordResetEmailSentScreen> {
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
          centerTitle: true,
          title: Text(
            LocalizationService.instance.getLocalizedString("success"),
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
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: successColor,
                    size: 64,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    LocalizationService.instance
                        .getLocalizedString("password_reset_email_sent"),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text(LocalizationService.instance
                        .getLocalizedString("go_to_login")),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
