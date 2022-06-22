// ignore_for_file: avoid_print

import 'package:dropdown_search/dropdown_search.dart';
import 'package:edft/models/app_user.dart';
import 'package:edft/providers/app_user_provider.dart';
import 'package:edft/service/user_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/functions.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/models.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/localization_service.dart';

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({Key? key}) : super(key: key);

  @override
  State<PersonalProfileScreen> createState() => PersonalProfileScreenState();
}

class PersonalProfileScreenState extends State<PersonalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _yearOfBirthController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _yearOfBirthController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  //After each State Change we have to update the model values from controller values
  void updateFromControllers(AppUser user) {
    user.yearOfBirth = _yearOfBirthController.text;
  }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserProvider>(context).getUser;
    _yearOfBirthController = TextEditingController(text: user.yearOfBirth);
    return WillPopScope(
      onWillPop: () async {
        UserService().refreshUser(context);
        return Future.value(true);
      },
      child: Scaffold(
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
                          .getLocalizedString("profile_disclaimer"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Focus(
                      //always update on focus out (make sure we have the most up to date info)
                      onFocusChange: (hasFocus) {
                        if (!hasFocus) {
                          updateFromControllers(user);
                        }
                      },
                      child: TextFormFieldInput(
                        controller: _yearOfBirthController,
                        inputSize: 4,
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
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                      value: user.gender,
                      decoration: getDropdownDecoration(
                        context,
                        LocalizationService.instance
                            .getLocalizedString("gender"),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          user.gender = value;
                        });
                      },
                      items: genderList,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                      value: user.relationShipStatus,
                      decoration: getDropdownDecoration(
                        context,
                        LocalizationService.instance
                            .getLocalizedString("relationship_status"),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          user.relationShipStatus = value;
                        });
                      },
                      items: relationshipStatusList,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownSearch<Country>(
                      popupProps: PopupProps.menu(
                        isFilterOnline: false,
                        showSelectedItems: true,
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                              label: Text(LocalizationService.instance
                                  .getLocalizedString("search_ellipsis"))),
                        ),
                      ),
                      dropdownSearchDecoration: getDropdownDecoration(
                        context,
                        LocalizationService.instance
                            .getLocalizedString("country"),
                      ),
                      itemAsString: (Country c) => c.toString(),
                      showClearButton: true,
                      onChanged: (Country? data) {
                        setState(() {
                          user.country = data;
                        });
                      },
                      compareFn: (c1, c2) =>
                          c1.code == c2.code, //Comparing countries
                      selectedItem: user.country,
                      items:
                          LocalizationService.instance.getPreferredLanguage() ==
                                  'pt'
                              ? countriesPt
                              : countriesEn,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: primaryColor,
                            ))
                          : Text(LocalizationService.instance
                              .getLocalizedString("update")),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          updateFromControllers(user);
                          UserService().updateUser(user, context);
                          showSnackBar(
                              context,
                              LocalizationService.instance
                                  .getLocalizedString("update_successful"),
                              "success");
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
