// ignore_for_file: avoid_print
import 'package:edft/screens/attractions_screen.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../localization/localization_service.dart';

class AttractionsMenuScreen extends StatefulWidget {
  final String cityId;
  const AttractionsMenuScreen({Key? key, required this.cityId})
      : super(key: key);

  @override
  State<AttractionsMenuScreen> createState() => AttractionsMenuScreenState();
}

class AttractionsMenuScreenState extends State<AttractionsMenuScreen> {
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
                LocalizationService.instance
                    .getLocalizedString("choose_attraction_category"),
              ),
            ),
            Center(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: attractionPreferencesList.length,
                itemBuilder: (context, i) {
                  return AttractionMenuCard(
                    name: attractionPreferencesList[i].name,
                    image: attractionPreferencesList[i].image,
                    category: attractionPreferencesList[i].category,
                    cityId: widget.cityId,
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 264,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttractionMenuCard extends StatelessWidget {
  final String name;
  final String image;
  final String category;
  final String cityId;

  const AttractionMenuCard({
    Key? key,
    required this.name,
    required this.image,
    required this.category,
    required this.cityId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Container(
        height: 290,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AttractionsScreen(),
                        ),
                      );
                    },
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    name,
                    style: const TextStyle(color: offWhiteColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
