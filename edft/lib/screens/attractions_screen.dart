// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/models/attraction.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/providers/travel_provider.dart';
import 'package:edft/screens/attraction_detail.dart';
import 'package:edft/service/attraction_service.dart';
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
  //Order the Stream Documents in a List by custom order
  List<Attraction> _orderAttractionList(
      {required List<QueryDocumentSnapshot> docs,
      required String sortType,
      required Travel travel}) {
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
    if (sortType == "distance") {
      res.sort((a, b) =>
          a.distanceToStayLocation!.compareTo(b.distanceToStayLocation!));
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    Travel travel = Provider.of<TravelProvider>(context).getTravel!;
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
              //Order the stream
              List<Attraction> attractionOrderedList = _orderAttractionList(
                  docs: snapshot.data!.docs,
                  sortType: "distance",
                  travel: travel);
              return ListView.separated(
                itemCount: attractionOrderedList.length,
                itemBuilder: (ctx, index) {
                  Attraction attr = attractionOrderedList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttractionDetail(attr: attr),
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
    );
  }
}
