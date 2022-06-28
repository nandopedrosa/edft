// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/models/attraction.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/providers/travel_provider.dart';
import 'package:edft/screens/attraction_detail.dart';
import 'package:edft/service/attraction_service.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/localization_service.dart';
import 'package:edft/widgets/attraction_entry.dart';

class AttractionsScreen extends StatefulWidget {
  final String cityId;
  final String category;
  const AttractionsScreen(
      {Key? key, required this.cityId, required this.category})
      : super(key: key);

  @override
  State<AttractionsScreen> createState() => AttractionsScreenState();
}

class AttractionsScreenState extends State<AttractionsScreen> {
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
              .where("cityId", isEqualTo: widget.cityId)
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
              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) {
                  Map<String, dynamic> attractionMap =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  attractionMap['id'] = snapshot.data!.docs[index].id;
                  Attraction attr = Attraction.fromMap(attractionMap);
                  bool isAdded = travel.attractions.contains(attr.id);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttractionDetail(
                            id: attr.id,
                            name: attr.name,
                            description: attr.description,
                            url: attr.url,
                            isAdded: isAdded,
                          ),
                        ),
                      );
                    },
                    child: AttractionEntry(
                      name: attr.name,
                      image: attr.image,
                      address: attr.address,
                      category: attr.category,
                      budget: attr.budget,
                      isAdded: isAdded,
                    ),
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
