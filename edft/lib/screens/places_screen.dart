// ignore_for_file: avoid_print
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import '../localization/localization_service.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  State<PlacesScreen> createState() => PlacesScreenState();
}

class PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const MyBottomNavigationBar(currentPage: homePageIndex),
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: appBarTitle,
        title: Text(
          LocalizationService.instance.getLocalizedString("places"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: const <Widget>[
            TripCard(),
            SizedBox(height: 10),
            TripCard(),
            SizedBox(height: 10),
            TripCard(),
            SizedBox(height: 10),
            TripCard(),
            SizedBox(height: 10),
            TripCard(),
            SizedBox(height: 10),
            TripCard(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
