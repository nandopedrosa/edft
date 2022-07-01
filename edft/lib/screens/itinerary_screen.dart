import 'package:edft/localization/localization_service.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/screens/alert_screen.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class ItineraryScreen extends StatefulWidget {
  final Travel travel;
  const ItineraryScreen({Key? key, required this.travel}) : super(key: key);

  @override
  State<ItineraryScreen> createState() => ItineraryScreenState();
}

class ItineraryScreenState extends State<ItineraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const MyBottomNavigationBar(currentPage: aboutPageIndex),
      appBar: AppBar(
        titleTextStyle: appBarTitle,
        centerTitle: true,
        title: Text(
          LocalizationService.instance.getLocalizedString("itinerary"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AlertScreen(),
                  ),
                );
              },
              child: const ListTile(
                title: Text('Alertas'),
                subtitle: Text(
                  'Encontramos alguns alertas para sua viagem. Clique aqui para vê-los.',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                ),
                trailing: Icon(
                  Icons.warning,
                  color: warningColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Divider(
                color: offWhiteColor,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.travel.attractions.length,
                itemBuilder: (context, index) {
                  return const ListTile(
                    leading: Text(
                      "14:30",
                      style: TextStyle(color: Colors.white),
                    ),
                    title: Text("Atração"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
