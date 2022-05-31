// ignore_for_file: avoid_print

import 'package:edft/utils/colors.dart';
import 'package:edft/utils/styles.dart';
import 'package:flutter/material.dart';

import '../localization/localization_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: appBarTitle,
        title: Text(
          LocalizationService.instance.getLocalizedString("new_account"),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,                
                  controller: _passwordController,
                  //TODO: extrair um textinput generico
                  decoration: const InputDecoration(
                    filled: true,
                    border:  OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: Text(LocalizationService.instance
                      .getLocalizedString("create_account")),
                  onPressed: () {
                    print(_nameController.text);
                    print(_passwordController.text);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
