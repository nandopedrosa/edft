// ignore_for_file: avoid_print
import 'package:edft/screens/attraction_detail.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../localization/localization_service.dart';
import 'package:edft/widgets/attraction_entry.dart';

class AttractionsScreen extends StatefulWidget {
  const AttractionsScreen({Key? key}) : super(key: key);

  @override
  State<AttractionsScreen> createState() => AttractionsScreenState();
}

class AttractionsScreenState extends State<AttractionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const MyBottomNavigationBar(currentPage: homePageIndex),
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: appBarTitle,
        title: Text(
          LocalizationService.instance.getLocalizedString("attractions"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Recife - Restaurante",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AttractionDetail(
                        attractionTitle: "Chica Bacana", isAdded: true),
                  ),
                );
              },
              child: const AttractionEntry(isAdded: true),
            ),
            const Divider(
              color: offWhiteColor,
            ),
            const AttractionEntry(
              isAdded: false,
            ),
            const Divider(
              color: offWhiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
