// ignore_for_file: avoid_print

import 'package:dropdown_search/dropdown_search.dart';
import 'package:edft/screens/itinerary_screen.dart';
import 'package:edft/screens/attractions_screen.dart';
import 'package:edft/utils/functions.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/models.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../localization/localization_service.dart';

class TravelDetailsScreen extends StatefulWidget {
  const TravelDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TravelDetailsScreen> createState() => TravelDetailsScreenState();
}

class TravelDetailsScreenState extends State<TravelDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _travelNameController = TextEditingController();
  final TextEditingController _numberOfTravelersController =
      TextEditingController();
  Country? _selectedCountry;
  City? _selectedCity;
  String? _selectedTransport;
  String? _selectedAccomodation;
  DateTime? _arrivalDate;
  DateTime? _departureDate;
  String? _travelId;

  @override
  void dispose() {
    super.dispose();
    _travelNameController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  List<City> _getCities(Country? country) {
    if (country == null) {
      return [];
    }

    if (LocalizationService.instance.getPreferredLanguage() == 'pt') {
      return citiesPt.where((c) => c.countryCode == country.code).toList();
    } else {
      return citiesEn.where((c) => c.countryCode == country.code).toList();
    }
  }

  void _showDatePicker(BuildContext context, String dateType) {
    DatePicker.showDatePicker(
      context,
      minTime: DateTime.now(),
      currentTime: DateTime.now(),
      locale: LocalizationService.instance.getPreferredLanguage() == 'pt'
          ? LocaleType.pt
          : LocaleType.en,
      onConfirm: (date) {
        setState(() {
          if (dateType == "arrival") {
            _arrivalDate = date;
          } else if (dateType == "departure") {
            _departureDate = date;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const MyBottomNavigationBar(currentPage: homePageIndex),
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: appBarTitle,
        title: Text(
          LocalizationService.instance.getLocalizedString("travel_details"),
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
                  child: TextFormFieldInput(
                    inputSize: 32,
                    controller: _travelNameController,
                    isPass: false,
                    hintText: LocalizationService.instance
                        .getLocalizedString("enter_travel_name"),
                    labelText: LocalizationService.instance
                        .getLocalizedString("travel_name"),
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
                    inputSize: 2,
                    controller: _numberOfTravelersController,
                    isPass: false,
                    hintText: LocalizationService.instance
                        .getLocalizedString("enter_number_of_travelers"),
                    labelText: LocalizationService.instance
                        .getLocalizedString("number_of_travelers"),
                    textInputType: TextInputType.number,
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
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_today,
                          color: Colors.white70),
                      onPressed: () {
                        _showDatePicker(context, "arrival");
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white70,
                        side: const BorderSide(color: Colors.white54),
                      ),
                      label: _arrivalDate == null
                          ? Text(LocalizationService.instance
                              .getLocalizedString("arrival"))
                          // ignore: prefer_interpolation_to_compose_strings
                          : Text(LocalizationService.instance
                                  .getLocalizedString("arrival") +
                              ": " +
                              LocalizationService.instance
                                  .getFullLocalizedDateAndTime(
                                      _arrivalDate.toString())!),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_today,
                          color: Colors.white70),
                      onPressed: () {
                        _showDatePicker(context, "departure");
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white70,
                        side: const BorderSide(color: Colors.white54),
                      ),
                      label: _departureDate == null
                          ? Text(LocalizationService.instance
                              .getLocalizedString("departure"))
                          // ignore: prefer_interpolation_to_compose_strings
                          : Text(LocalizationService.instance
                                  .getLocalizedString("departure") +
                              ": " +
                              LocalizationService.instance
                                  .getFullLocalizedDateAndTime(
                                      _arrivalDate.toString())!),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                    value: _selectedTransport,
                    decoration: getDropdownDecoration(
                      context,
                      LocalizationService.instance
                          .getLocalizedString("transport"),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedTransport = value;
                      });
                    },
                    items: transportPreferenceList,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                    value: _selectedAccomodation,
                    decoration: getDropdownDecoration(
                      context,
                      LocalizationService.instance
                          .getLocalizedString("accomodation"),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedAccomodation = value;
                      });
                    },
                    items: accomodationPreferenceList,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownSearch<Country>(
                    popupProps: PopupProps.menu(
                      isFilterOnline: false,
                      showSelectedItems: false,
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
                        _selectedCountry = data;
                      });
                    },
                    selectedItem: _selectedCountry,
                    items:
                        LocalizationService.instance.getPreferredLanguage() ==
                                'pt'
                            ? countriesBr
                            : countriesEn,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownSearch<City>(
                      popupProps: PopupProps.menu(
                        isFilterOnline: false,
                        showSelectedItems: false,
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                              label: Text(LocalizationService.instance
                                  .getLocalizedString("search_ellipsis"))),
                        ),
                      ),
                      dropdownSearchDecoration: getDropdownDecoration(
                        context,
                        LocalizationService.instance.getLocalizedString("city"),
                      ),
                      itemAsString: (City c) => c.toString(),
                      showClearButton: true,
                      onChanged: (City? data) {
                        setState(() {
                          _selectedCity = data;
                        });
                      },
                      selectedItem: _selectedCity,
                      items: _getCities(_selectedCountry)),
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
                          builder: (context) => const AttractionsScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          LocalizationService.instance
                              .getLocalizedString("see_add_attractions"),
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ItineraryScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          LocalizationService.instance
                              .getLocalizedString("see_itinerary"),
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
                const SizedBox(height: 40),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text(LocalizationService.instance
                        .getLocalizedString("confirm")),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO: cadastrar viagem
                        print(_arrivalDate);
                        print(_departureDate);
                        print(_selectedCity);

                        if (_travelId == null || _travelId!.isEmpty) {
                          //New travel
                          showSnackBar(
                            context,
                            // ignore: prefer_interpolation_to_compose_strings
                            LocalizationService.instance.getLocalizedString(
                                    "travel_details_updated") +
                                " " +
                                LocalizationService.instance.getLocalizedString(
                                    "dont_forget_to_add_places"),
                          );
                        } else {
                          //Existing travel
                          showSnackBar(
                            context,
                            LocalizationService.instance
                                .getLocalizedString("travel_details_updated"),
                          );
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          )),
    );
  }
}
