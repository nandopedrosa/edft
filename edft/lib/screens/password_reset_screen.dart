// ignore_for_file: avoid_print

import 'package:edft/screens/password_reset_success_screen.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';

import '../localization/localization_service.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => PasswordResetScreenState();
}

class PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: appBarTitle,
        title: Text(
          LocalizationService.instance.getLocalizedString("password_reset"),
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
                    LocalizationService.instance
                        .getLocalizedString("inform_code"),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormFieldInput(
                    controller: _codeController,
                    isPass: false,
                    hintText: LocalizationService.instance
                        .getLocalizedString("enter_code"),
                    labelText:
                        LocalizationService.instance.getLocalizedString("code"),
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocalizationService.instance
                            .getLocalizedString("mandatory_field");
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormFieldInput(
                    controller: _passwordController,
                    isPass: true,
                    hintText: LocalizationService.instance
                        .getLocalizedString("enter_password"),
                    labelText: LocalizationService.instance
                        .getLocalizedString("password"),
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocalizationService.instance
                            .getLocalizedString("mandatory_field");
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormFieldInput(
                    controller: _passwordConfirmationController,
                    isPass: true,
                    hintText: LocalizationService.instance
                        .getLocalizedString("confirm_password"),
                    labelText: LocalizationService.instance
                        .getLocalizedString("password_confirmation"),
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocalizationService.instance
                            .getLocalizedString("mandatory_field");
                      }

                      if (value != _passwordController.text) {
                        return LocalizationService.instance
                            .getLocalizedString("password_mismatch");
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
                        //TODO: validar código e redefinir senha no firebase
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PasswordResetSuccessScreen(),
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
