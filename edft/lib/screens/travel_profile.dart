// ignore_for_file: avoid_print

import 'package:edft/models/app_user.dart';
import 'package:edft/providers/app_user_provider.dart';
import 'package:edft/service/user_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/functions.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/models.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../localization/localization_service.dart';

class TravelProfileScreen extends StatefulWidget {
  const TravelProfileScreen({Key? key}) : super(key: key);

  @override
  State<TravelProfileScreen> createState() => TravelProfileScreenState();
}

class TravelProfileScreenState extends State<TravelProfileScreen> {
  bool _isLoading = false;
  final _attractions = attractionPreferencesList
      .map((attraction) =>
          MultiSelectItem<AttractionPreference>(attraction, attraction.name))
      .toList();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserProvider>(context).getUser;
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
            LocalizationService.instance.getLocalizedString("travel_profile"),
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
                    child: DropdownButtonFormField(
                      value: user.preferenceAccomodation,
                      decoration: getDropdownDecoration(
                        context,
                        LocalizationService.instance
                            .getLocalizedString("accomodation_preference"),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          user.preferenceAccomodation = value;
                        });
                      },
                      items: accomodationPreferenceList,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                      value: user.preferenceTransport,
                      decoration: getDropdownDecoration(
                        context,
                        LocalizationService.instance
                            .getLocalizedString("transport_preference"),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          user.preferenceTransport = value;
                        });
                      },
                      items: transportPreferenceList,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                      value: user.preferenceBudget,
                      decoration: getDropdownDecoration(
                        context,
                        LocalizationService.instance
                            .getLocalizedString("budget_preference"),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          user.preferenceBudget = value;
                        });
                      },
                      items: budgetPreferenceList,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: MultiSelectDialogField<AttractionPreference>(
                        initialValue: user.getAttractions(),
                        selectedItemsTextStyle:
                            const TextStyle(color: Colors.blue),
                        itemsTextStyle: const TextStyle(color: Colors.white),
                        unselectedColor: Colors.white,
                        title: Text(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            LocalizationService.instance
                                .getLocalizedString("attractions_preferences")),
                        confirmText: const Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                        cancelText: Text(
                          LocalizationService.instance
                              .getLocalizedString("cancel")
                              .toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: fillColor, width: 2),
                          color: fillColor,
                        ),
                        buttonIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white70,
                        ),
                        buttonText: Text(
                          LocalizationService.instance
                              .getLocalizedString("attractions_preferences"),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                        items: _attractions,
                        onConfirm: (List<AttractionPreference> attractions) {
                          setState(() {
                            List<String> selectedAttractions = [];
                            for (AttractionPreference a in attractions) {
                              selectedAttractions.add(a.category);
                            }
                            user.preferenceAttractions = selectedAttractions;
                          });
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : Text(LocalizationService.instance
                              .getLocalizedString("update")),
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        UserService().updateUser(user, context);
                        showSnackBar(
                          context,
                          LocalizationService.instance
                              .getLocalizedString("update_successful"),
                          'success',
                        );

                        setState(() {
                          _isLoading = false;
                        });
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
