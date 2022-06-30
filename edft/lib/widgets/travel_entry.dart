import 'package:edft/localization/localization_service.dart';
import 'package:edft/screens/travel_details.dart';
import 'package:edft/utils/colors.dart';
import 'package:flutter/material.dart';

class TravelEntry extends StatelessWidget {
  final String travelId;
  final String travelName;
  final String countryName;
  final String cityName;
  final String arrivalDate;
  final String departureDate;

  const TravelEntry({
    Key? key,
    required this.travelId,
    required this.travelName,
    required this.countryName,
    required this.cityName,
    required this.arrivalDate,
    required this.departureDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.flytap.com/-/media/Flytap/new-tap-pages/destinations/south-america/brazil/recife/recife-banner-mobile-1024x553.jpg"),
          ),
          title: Text("$cityName, $countryName"),
          subtitle: Text(
            travelName,
            style: const TextStyle(
              color: secondaryColor,
              fontSize: 12,
            ),
          ),
          trailing: Text(
            '$arrivalDate - $departureDate',
            style: const TextStyle(
              color: secondaryColor,
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(purpleColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: purpleColor)))),
                onPressed: () {},
                child: Text(
                  LocalizationService.instance.getLocalizedString("itinerary"),
                  style: const TextStyle(color: offWhiteColor),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                child: Text(
                  LocalizationService.instance.getLocalizedString("details"),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TravelDetailsScreen(
                        travelId: travelId,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}
