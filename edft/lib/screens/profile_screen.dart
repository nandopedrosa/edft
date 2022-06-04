// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:edft/screens/personal_profile.dart';
import 'package:edft/screens/travel_profile.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../localization/localization_service.dart';
import '../utils/functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
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

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const MyBottomNavigationBar(currentPage: profilePageIndex),
      appBar: AppBar(
        titleTextStyle: appBarTitle,
        centerTitle: true,
        title: Text(
          LocalizationService.instance.getLocalizedString("profile"),
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
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalProfileScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          LocalizationService.instance
                              .getLocalizedString("personal_profile"),
                          style: Theme.of(context).textTheme.subtitle1!,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TravelProfileScreen(),
                            ),
                          );
                        },
                        child: Text(
                          LocalizationService.instance
                              .getLocalizedString("travel_profile"),
                          style: Theme.of(context).textTheme.subtitle1!,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text(LocalizationService.instance
                        .getLocalizedString("update")),
                    onPressed: () {
                      //TODO: update profile
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          )),
    );
  }
}
