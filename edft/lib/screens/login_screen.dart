// ignore_for_file: avoid_print
import 'package:edft/localization/localization_service.dart';
import 'package:edft/screens/signup_screen.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/styles.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
            titleTextStyle: appBarTitle,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                "assets/images/bg.jpg",
                fit: BoxFit.cover,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                controller: _usernameController,
                                keyboardType: TextInputType.emailAddress,
                                //TODO: validate
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocalizationService.instance
                                        .getLocalizedString("mandatory_field");
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: LocalizationService.instance
                                        .getLocalizedString("enter_email"),
                                    labelText: LocalizationService.instance
                                        .getLocalizedString("username")),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocalizationService.instance
                                        .getLocalizedString("mandatory_field");
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: LocalizationService.instance
                                      .getLocalizedString("enter_password"),
                                  labelText: LocalizationService.instance
                                      .getLocalizedString("password"),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              InkWell(
                                onTap: () {
                                  print("Logou!");
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                    color: blueColor,
                                  ),
                                  child: const Text("Log in"),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      LocalizationService.instance
                                          .getLocalizedString(
                                              "dont_have_account"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        LocalizationService.instance
                                            .getLocalizedString("signup"),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
