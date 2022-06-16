// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:edft/screens/password_reset_email_sent_screen.dart';
import 'package:edft/service/user_service.dart';
import 'package:edft/utils/functions.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';

import '../localization/localization_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String res = await UserService()
                            .resetPassword(email: _emailController.text);
                        if (res == 'success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PasswordResetEmailSentScreen(),
                            ),
                          );
                        } else {
                          showSnackBar(context, res, 'error');
                        }
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
