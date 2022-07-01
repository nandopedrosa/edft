// ignore_for_file: avoid_print, must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/providers/travel_provider.dart';
import 'package:edft/screens/itinerary_screen.dart';
import 'package:edft/screens/attractions_menu_screen.dart';
import 'package:edft/service/travel_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/functions.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/models.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../localization/localization_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TravelDetailsScreen extends StatefulWidget {
  String? travelId;
  TravelDetailsScreen({Key? key, this.travelId}) : super(key: key);

  @override
  State<TravelDetailsScreen> createState() => TravelDetailsScreenState();
}

class TravelDetailsScreenState extends State<TravelDetailsScreen> {
  final _cityDropdownKey = GlobalKey<DropdownSearchState<City>>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _travelNameController = TextEditingController();
  TextEditingController _numberOfTravelersController = TextEditingController();
  Travel travel = Travel.empty();

  @override
  void dispose() {
    super.dispose();
    _travelNameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getTravelData();
  }

  getTravelData() async {
    //Travel ID can be null if we are creating a new one
    if (widget.travelId != null) {
      TravelProvider travelProvider = Provider.of(context, listen: false);
      await travelProvider.refreshTravel(widget.travelId!);
    }
  }

  String validateDates() {
    String res = "success";
    if (travel.arrivalDate == null || travel.departureDate == null) {
      return LocalizationService.instance
          .getLocalizedString("arrival_departure_mandatories");
    }

    if (DateTime.parse(travel.arrivalDate!)
            .compareTo(DateTime.parse(travel.departureDate!)) >
        0) {
      return LocalizationService.instance
          .getLocalizedString("arrival_before_departure");
    }

    if (DateTime.parse(travel.departureDate!)
            .compareTo(DateTime.parse(travel.arrivalDate!)) <
        0) {
      return LocalizationService.instance
          .getLocalizedString("departure_after_arrival");
    }

    return res;
  }

  String getStayLocationLabel(Travel t) {
    if (t.stayName == null) {
      return "";
    } else {
      return "${t.stayName}\n${t.stayAddress}";
    }
  }

  List<City> _getCities(String? countryCode) {
    List<City> res = [];
    if (countryCode == null) {
      return res;
    }

    if (LocalizationService.instance.getPreferredLanguage() == 'pt') {
      res = citiesPt.where((c) => c.countryCode == countryCode).toList();
    } else {
      res = citiesEn.where((c) => c.countryCode == countryCode).toList();
    }

    res.sort((a, b) => a.name.compareTo(b.name));
    return res;
  }

  void _showDatePicker(BuildContext context, String dateType, Travel travel) {
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
            travel.arrivalDate = date.toIso8601String();
          } else if (dateType == "departure") {
            travel.departureDate = date.toIso8601String();
          }
        });
      },
    );
  }

  //After each State Change we have to update the model values from controller values
  void updateFromControllers(Travel travel) {
    travel.name = _travelNameController.text;
    travel.numberOfTravelers = _numberOfTravelersController.text;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.travelId != null) {
      travel = Provider.of<TravelProvider>(context).getTravel ?? Travel.empty();
    }

    _travelNameController = TextEditingController(text: travel.name);
    _numberOfTravelersController =
        TextEditingController(text: travel.numberOfTravelers);

    return WillPopScope(
      onWillPop: () async {
        TravelService().refreshTravel(context, widget.travelId);
        return Future.value(true);
      },
      child: Scaffold(
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      LocalizationService.instance
                          .getLocalizedString("travel_details_disclaimer"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        if (!hasFocus) {
                          updateFromControllers(travel);
                        }
                      },
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
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        if (!hasFocus) {
                          updateFromControllers(travel);
                        }
                      },
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
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.calendar_today,
                            color: offWhiteColor),
                        onPressed: () {
                          _showDatePicker(context, "arrival", travel);
                        },
                        style: OutlinedButton.styleFrom(
                          primary: offWhiteColor,
                          side: const BorderSide(color: offWhiteColor),
                        ),
                        label: travel.arrivalDate == null
                            ? Text(LocalizationService.instance
                                .getLocalizedString("arrival"))
                            // ignore: prefer_interpolation_to_compose_strings
                            : Text(LocalizationService.instance
                                    .getLocalizedString("arrival") +
                                ": " +
                                LocalizationService.instance
                                    .getFullLocalizedDateAndTime(
                                        travel.arrivalDate)!),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.calendar_today,
                            color: offWhiteColor),
                        onPressed: () {
                          _showDatePicker(context, "departure", travel);
                        },
                        style: OutlinedButton.styleFrom(
                          primary: offWhiteColor,
                          side: const BorderSide(color: offWhiteColor),
                        ),
                        label: travel.departureDate == null
                            ? Text(LocalizationService.instance
                                .getLocalizedString("departure"))
                            // ignore: prefer_interpolation_to_compose_strings
                            : Text(LocalizationService.instance
                                    .getLocalizedString("departure") +
                                ": " +
                                LocalizationService.instance
                                    .getFullLocalizedDateAndTime(
                                        travel.departureDate)!),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return LocalizationService.instance
                              .getLocalizedString("mandatory_field");
                        }
                        return null;
                      },
                      value: travel.transportCode,
                      decoration: getDropdownDecoration(
                        context,
                        LocalizationService.instance
                            .getLocalizedString("transport"),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          travel.transportCode = value;
                        });
                      },
                      items: transportPreferenceList,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return LocalizationService.instance
                              .getLocalizedString("mandatory_field");
                        }
                        return null;
                      },
                      value: travel.accomodationCode,
                      decoration: getDropdownDecoration(
                        context,
                        LocalizationService.instance
                            .getLocalizedString("accomodation"),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          travel.accomodationCode = value;
                        });
                      },
                      items: accomodationPreferenceList,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownSearch<Country>(
                      validator: (Country? value) {
                        if (value == null) {
                          return LocalizationService.instance
                              .getLocalizedString("mandatory_field");
                        }
                        return null;
                      },
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
                      onChanged: (Country? data) {
                        setState(() {
                          travel.countryCode = data!.code;
                          _cityDropdownKey.currentState?.clear();
                        });
                      },
                      selectedItem: travel.getCountry(),
                      items:
                          LocalizationService.instance.getPreferredLanguage() ==
                                  'pt'
                              ? countriesPt
                              : countriesEn,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: DropdownSearch<City>(
                      key: _cityDropdownKey,
                      validator: (City? value) {
                        if (value == null) {
                          return LocalizationService.instance
                              .getLocalizedString("mandatory_field");
                        }
                        return null;
                      },
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
                      onChanged: (City? data) {
                        setState(() {
                          travel.cityId = data?.id;
                        });
                      },
                      selectedItem: travel.getCity(),
                      items: _getCities(travel.countryCode),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      LocalizationService.instance
                          .getLocalizedString("pick_stay_location"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.location_pin,
                            color: offWhiteColor),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']!,
                                initialPosition: travel.stayName != null
                                    ? LatLng(double.parse(travel.stayLat!),
                                        double.parse(travel.stayLng!))
                                    : const LatLng(atlanticOceanLatitude,
                                        atlanticOceanLongitude),
                                useCurrentLocation: true,
                                onPlacePicked: (place) {
                                  setState(() {
                                    travel.stayName = place.name;
                                    travel.stayAddress = place.formattedAddress;
                                    travel.stayLat =
                                        place.geometry!.location.lat.toString();
                                    travel.stayLng =
                                        place.geometry!.location.lng.toString();
                                    travel.stayMapsId = place.placeId;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          primary: offWhiteColor,
                          side: const BorderSide(color: offWhiteColor),
                        ),
                        label: Text(getStayLocationLabel(travel)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                      child: Text(
                        LocalizationService.instance
                            .getLocalizedString("confirm"),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //Validate dates (the rest is validated through the Form)
                          String dateValidationMsg = validateDates();
                          if (dateValidationMsg != "success") {
                            showSnackBar(context, dateValidationMsg, "error");
                            return;
                          }

                          //Validate Stay Location
                          if (travel.stayName == null) {
                            showSnackBar(
                                context,
                                LocalizationService.instance.getLocalizedString(
                                    "stay_location_mandatory"),
                                "error");
                            return;
                          }

                          updateFromControllers(travel);
                          TravelService().updateTravel(travel, context);

                          if (widget.travelId == null ||
                              widget.travelId!.isEmpty) {
                            showSnackBar(
                              context,
                              // ignore: prefer_interpolation_to_compose_strings
                              LocalizationService.instance
                                      .getLocalizedString("travel_created") +
                                  " " +
                                  LocalizationService.instance
                                      .getLocalizedString(
                                          "dont_forget_to_add_places"),
                              'success',
                            );
                            setState(() {
                              widget.travelId = travel.id;
                            });
                          } else {
                            //Existing travel
                            showSnackBar(
                              context,
                              LocalizationService.instance
                                  .getLocalizedString("travel_details_updated"),
                              'success',
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TravelAction(
                    actionText: LocalizationService.instance
                        .getLocalizedString("attractions"),
                    actionFunction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttractionsMenuScreen(
                            cityId: travel.cityId!,
                          ),
                        ),
                      );
                    },
                    travelId: widget.travelId,
                  ),
                  TravelAction(
                    actionText: LocalizationService.instance
                        .getLocalizedString("see_itinerary"),
                    actionFunction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItineraryScreen(travel: travel),
                        ),
                      );
                    },
                    travelId: widget.travelId,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )),
      ),
    );
  }
}

class TravelAction extends StatelessWidget {
  String actionText;
  final VoidCallback actionFunction;
  String? travelId; //we use this to show or not show de TravelAction
  TravelAction(
      {Key? key,
      required this.actionText,
      required this.actionFunction,
      this.travelId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (travelId != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 30),
        child: GestureDetector(
          onTap: actionFunction,
          child: Row(
            children: [
              Text(
                actionText,
                style: Theme.of(context).textTheme.subtitle1!,
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink(); //empty widget
    }
  }
}
