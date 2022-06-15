// ignore_for_file: avoid_print
import 'package:edft/screens/travel_details.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/trip_entry.dart';
import 'package:flutter/material.dart';
import '../localization/localization_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar:
            const MyBottomNavigationBar(currentPage: homePageIndex),
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                iconSize: 32,
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TravelDetailsScreen(),
                    ),
                  );
                },
              ),
            )
          ],
          titleTextStyle: appBarTitle,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            LocalizationService.instance.getLocalizedString("my_trips"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: const <Widget>[
              TripEntry(),
              Divider(
                color: offWhiteColor,
              ),
              TripEntry(),
              Divider(
                color: offWhiteColor,
              ),
              TripEntry(),
              Divider(
                color: offWhiteColor,
              ),
              TripEntry(),
              Divider(
                color: offWhiteColor,
              ),
              TripEntry(),
              Divider(
                color: offWhiteColor,
              ),
              TripEntry(),
              Divider(
                color: offWhiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
