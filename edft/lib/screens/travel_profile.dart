// ignore_for_file: avoid_print

import 'package:edft/screens/password_reset_screen.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';

import '../localization/localization_service.dart';

class TravelProfileScreen extends StatefulWidget {
  const TravelProfileScreen({Key? key}) : super(key: key);

  @override
  State<TravelProfileScreen> createState() => TravelProfileScreenState();
}

class TravelProfileScreenState extends State<TravelProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const MyBottomNavigationBar(currentPage: profilePageIndex),
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: appBarTitle,
        title: Text(
          LocalizationService.instance.getLocalizedString("forgot_password"),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    LocalizationService.instance.getLocalizedString("alright"),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormFieldInput(
                    controller: _emailController,
                    isPass: false,
                    hintText: LocalizationService.instance
                        .getLocalizedString("enter_email"),
                    labelText: LocalizationService.instance
                        .getLocalizedString("email"),
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocalizationService.instance
                            .getLocalizedString("mandatory_field");
                      }
                      return null;
                    },
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
                        .getLocalizedString("continue")),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO: resetar senha do usuário no Firebase, enviar código por email
                        print("informou email para resetar senha!");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PasswordResetScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
