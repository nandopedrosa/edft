import 'package:edft/localization/localization_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:flutter/material.dart';

class TripEntry extends StatelessWidget {
  const TripEntry({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(
            top: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.flytap.com/-/media/Flytap/new-tap-pages/destinations/south-america/brazil/recife/recife-banner-mobile-1024x553.jpg"),
            ),
            title: Text('Brasil, Recife'),
            subtitle: Text(
              'Viagem com a família',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 12,
              ),
            ),
            trailing: Text(
              '01/01/2022 a 10/01/2022',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 12,
              ),
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
                        MaterialStateProperty.all<Color>(cardActionButtonColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                                color: cardActionButtonColor)))),
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
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}
