import 'package:edft/localization/localization_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  const TripCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(
              Icons.card_travel,
              color: cardLeadingIconColor,
            ),
            title: Text('Brasil, Recife'),
            subtitle: Text(
              '01/01/2022 a 10/01/2022',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          cardActionButtonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: cardActionButtonColor)))),
                  onPressed: () {},
                  child: Text(
                    LocalizationService.instance
                        .getLocalizedString("itinerary"),
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
      ),
    );
  }
}
