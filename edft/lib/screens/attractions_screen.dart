// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/models/attraction.dart';
import 'package:edft/screens/attraction_detail.dart';
import 'package:edft/service/attraction_service.dart';
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
        child: StreamBuilder(
          stream: AttractionService().getCollection().snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) {
                  Map<String, dynamic> attractionMap =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  attractionMap['id'] = snapshot.data!.docs[index].id;
                  Attraction attr = Attraction.fromMap(attractionMap);
                  return AttractionEntry(
                    name: attr.name,
                    image: attr.image,
                    address: attr.address,
                    category: attr.category,
                    budget: attr.budget,
                    isAdded: false,
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
