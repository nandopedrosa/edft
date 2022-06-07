// ignore_for_file: avoid_print

import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/models.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../localization/localization_service.dart';

class TravelProfileScreen extends StatefulWidget {
  const TravelProfileScreen({Key? key}) : super(key: key);

  @override
  State<TravelProfileScreen> createState() => TravelProfileScreenState();
}

class TravelProfileScreenState extends State<TravelProfileScreen> {
  String? _selectedAccomodationPreference;
  String? _selectedTransportPreference;
  String? _selectedAttractionsPreferences;
  String? _selectedBudgetPreference;
  final _attractions = attractionPreferencesList
      .map((attraction) =>
          MultiSelectItem<Attraction>(attraction, attraction.name))
      .toList();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
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
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                    value: _selectedAccomodationPreference,
                    decoration: getDropdownDecoration(
                      context,
                      LocalizationService.instance
                          .getLocalizedString("accomodation_preference"),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedAccomodationPreference = value;
                      });
                    },
                    items: accomodationPreferenceList,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                    value: _selectedTransportPreference,
                    decoration: getDropdownDecoration(
                      context,
                      LocalizationService.instance
                          .getLocalizedString("transport_preference"),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedTransportPreference = value;
                      });
                    },
                    items: transportPreferenceList,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                    value: _selectedBudgetPreference,
                    decoration: getDropdownDecoration(
                      context,
                      LocalizationService.instance
                          .getLocalizedString("budget_preference"),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedBudgetPreference = value;
                      });
                    },
                    items: budgetPreferenceList,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: MultiSelectDialogField(
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
                      onConfirm: (List<Attraction> attractions) {
                        String a = getAttractionsAsString(attractions);
                        setState(() {
                          _selectedAttractionsPreferences = a;
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
                    child: Text(LocalizationService.instance
                        .getLocalizedString("update")),
                    onPressed: () {
                      print(_selectedAccomodationPreference);
                      print(_selectedAttractionsPreferences);
                      print(_selectedBudgetPreference);
                      print(_selectedTransportPreference);
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  String getAttractionsAsString(List<Attraction> attractions) {
    String result = "";
    for (Attraction a in attractions) {
      result += "${a.code},";
    }
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }
}
