// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:edft/screens/signup_success_screen.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../localization/localization_service.dart';
import '../utils/functions.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  signup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      //TODO: criar conta no Firebase
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignupSuccessScreen(),
        ),
      );
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

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
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: _image == null
                      ? const CircleAvatar(
                          radius: 128,
                          backgroundImage:
                              AssetImage('assets/images/l60Hf.png'),
                          backgroundColor: Colors.grey,
                        )
                      : CircleAvatar(
                          radius: 128,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.grey,
                        ),
                ),
                GestureDetector(
                  onTap: selectImage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      LocalizationService.instance.getLocalizedString("edit"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormFieldInput(
                    controller: _nameController,
                    isPass: false,
                    hintText: LocalizationService.instance
                        .getLocalizedString("enter_name"),
                    labelText:
                        LocalizationService.instance.getLocalizedString("name"),
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text(LocalizationService.instance
                        .getLocalizedString("create_account")),
                    onPressed: () {
                      signup(context);
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
