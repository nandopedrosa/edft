// ignore_for_file: avoid_print

import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';

import '../localization/localization_service.dart';

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({Key? key}) : super(key: key);

  @override
  State<PersonalProfileScreen> createState() => PersonalProfileScreenState();
}

class PersonalProfileScreenState extends State<PersonalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _yearOfBirthController = TextEditingController();
  String _selectedGender = "";
  final List<DropdownMenuItem<String>> _genders = [
    DropdownMenuItem(
        value: "M",
        child: Text(LocalizationService.instance.getLocalizedString("male"))),
    DropdownMenuItem(
        value: "F",
        child: Text(LocalizationService.instance.getLocalizedString("female"))),
    DropdownMenuItem(
        value: "O",
        child: Text(LocalizationService.instance.getLocalizedString("other")))
  ];

  @override
  void dispose() {
    super.dispose();
    _yearOfBirthController.dispose();
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
          LocalizationService.instance.getLocalizedString("personal_profile"),
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
                        .getLocalizedString("personal_profile_disclaimer"),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormFieldInput(
                    controller: _yearOfBirthController,
                    isPass: false,
                    hintText: LocalizationService.instance
                        .getLocalizedString("enter_year_of_birth"),
                    labelText: LocalizationService.instance
                        .getLocalizedString("year_of_birth"),
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      //Validate year of birth. Min: 100 years ago. Max: now.
                      DateTime now = DateTime.now();
                      if (int.parse(value) > now.year ||
                          int.parse(value) < (now.year - 100)) {
                        return LocalizationService.instance
                            .getLocalizedString("invalid_year_of_birth");
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                    decoration: getDropdownDecoration(context),
                    hint: Text(LocalizationService.instance
                        .getLocalizedString("gender")),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value as String;
                      });
                    },
                    items: _genders,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text(LocalizationService.instance
                        .getLocalizedString("continue")),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(_selectedGender);
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
