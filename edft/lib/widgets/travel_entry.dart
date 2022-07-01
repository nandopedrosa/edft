import 'package:edft/localization/localization_service.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/screens/itinerary_screen.dart';
import 'package:edft/screens/travel_details.dart';
import 'package:edft/utils/colors.dart';
import 'package:flutter/material.dart';

class TravelEntry extends StatelessWidget {
  final Travel travel;

  const TravelEntry({
    Key? key,
    required this.travel,
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
          title:
              Text("${travel.getCity()!.name}, ${travel.getCountry()!.name}"),
          subtitle: Text(
            travel.name!,
            style: const TextStyle(
              color: secondaryColor,
              fontSize: 12,
            ),
          ),
          trailing: Text(
            '${LocalizationService.instance.getFullLocalizedDateAndTime(travel.arrivalDate)} - ${LocalizationService.instance.getFullLocalizedDateAndTime(travel.departureDate)}',
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItineraryScreen(
                        travel: travel,
                      ),
                    ),
                  );
                },
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
                        travelId: travel.id,
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
