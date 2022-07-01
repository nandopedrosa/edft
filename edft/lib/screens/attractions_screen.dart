// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/models/app_user.dart';
import 'package:edft/models/attraction.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/providers/app_user_provider.dart';
import 'package:edft/providers/travel_provider.dart';
import 'package:edft/screens/attraction_detail.dart';
import 'package:edft/service/attraction_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/functions.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/localization_service.dart';
import 'package:edft/widgets/attraction_entry.dart';

class AttractionsScreen extends StatefulWidget {
  final String category;
  const AttractionsScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<AttractionsScreen> createState() => AttractionsScreenState();
}

class AttractionsScreenState extends State<AttractionsScreen> {
  bool showAll = false;

  // Convert from snapshot documents to attraction list
  List<Attraction> _getAttractionListFromDocs(
      {required List<QueryDocumentSnapshot> docs, required Travel travel}) {
    List<Attraction> res = [];
    for (var snap in docs) {
      Map<String, dynamic> attractionMap = snap.data() as Map<String, dynamic>;
      attractionMap['id'] = snap.id;
      Attraction attr = Attraction.fromMap(attractionMap);
      attr.isAdded = travel.attractions.contains(attr.id);
      attr.distanceToStayLocation = calculateDistance(
              lat1: double.parse(attr.latitude),
              lng1: double.parse(attr.longitude),
              lat2: double.parse(travel.stayLat!),
              lng2: double.parse(travel.stayLng!))
          .toStringAsFixed(1);
      res.add(attr);
    }
    return res;
  }

  // Filter attraction by user preferences
  bool _shouldInclude({required Attraction attr, required AppUser user}) {
    bool res = true;

    // Filter by budget
    if (attr.budget.isNotEmpty) {
      if (int.parse(attr.budget) > getBudgetThreshold(user.preferenceBudget)) {
        res = false;
      }
    }
    //Other filters here...
    return res;
  }

// Filter attraction by user preferences
  List<Attraction> _filterAttractions(
      {required List<Attraction> attractions, required AppUser user}) {
    List<Attraction> res = [];
    for (Attraction attr in attractions) {
      if (_shouldInclude(attr: attr, user: user)) {
        res.add(attr);
      }
    }
    return res;
  }

  //Sort the attraction list  by custom order
  List<Attraction> _sortAttractions({
    required List<Attraction> attractions,
    String sortType = "default",
  }) {
    // The chosen attractions always appear first
    // Default sort is by DISTANCE from stay location
    if (sortType == "default") {
      attractions.sort((a, b) {
        // We want true values (added attractions) first
        int isAddedCompare =
            a.isAdded!.toString().compareTo(b.isAdded!.toString());
        if (isAddedCompare != 0) return isAddedCompare * -1;

        // If they are equal, now sort by distance
        int distanceCompare =
            a.distanceToStayLocation!.compareTo(b.distanceToStayLocation!);
        return distanceCompare;
      });
    }
    return attractions;
  }

  @override
  Widget build(BuildContext context) {
    Travel travel = Provider.of<TravelProvider>(context).getTravel!;
    AppUser user = Provider.of<UserProvider>(context).getUser;
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
        child: Column(
          children: [
            Text(
              LocalizationService.instance
                  .getLocalizedString("show_attractions_disclaimer"),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocalizationService.instance
                    .getLocalizedString("show_all")),
                Switch(
                  value: showAll,
                  onChanged: (value) {
                    setState(() {
                      showAll = value;
                    });
                  },
                  activeTrackColor: purpleColor.withAlpha(100),
                  activeColor: purpleColor,
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: AttractionService()
                    .getCollection()
                    .where("cityId", isEqualTo: travel.cityId)
                    .where("category", isEqualTo: widget.category)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.size == 0) {
                    // List of Documents can be empty if the city has no attractions
                    return Center(
                      child: Text(LocalizationService.instance
                          .getLocalizedString("no_attractions_found")),
                    );
                  } else {
                    List<Attraction> attractions = _getAttractionListFromDocs(
                        docs: snapshot.data!.docs, travel: travel);

                    //Sort the List
                    attractions = _sortAttractions(attractions: attractions);

                    if (!showAll) {
                      //Filter the List
                      attractions = _filterAttractions(
                          attractions: attractions, user: user);
                    }

                    return ListView.separated(
                      itemCount: attractions.length,
                      itemBuilder: (ctx, index) {
                        Attraction attr = attractions[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AttractionDetail(attr: attr),
                              ),
                            );
                          },
                          child: AttractionEntry(attr: attr),
                        );
                      },
                      separatorBuilder: (ctx, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } //fim do else
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
