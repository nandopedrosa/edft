// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/providers/app_user_provider.dart';
import 'package:edft/screens/travel_details.dart';
import 'package:edft/service/travel_service.dart';
import 'package:edft/service/user_service.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/travel_entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/localization_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  //Refresh User Data here so that we can use in future screens
  getUserData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

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
                      builder: (context) => TravelDetailsScreen(),
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
          padding: const EdgeInsets.only(top: 10),
          child: StreamBuilder(
            stream: TravelService()
                .getCollection()
                .where("userId", isEqualTo: UserService().getCurrentUserId())
                .snapshots(),
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
                    Travel t = Travel.fromMap(snapshot.data!.docs[index].data()
                        as Map<String, dynamic>);
                    return TravelEntry(
                      travelId: t.id!,
                      travelName: t.name!,
                      countryName: t.getCountry()!.name,
                      cityName: t.getCity()!.name,
                      arrivalDate: LocalizationService.instance
                          .getFullLocalizedDateAndTime(t.arrivalDate)!,
                      departureDate: LocalizationService.instance
                          .getFullLocalizedDateAndTime(t.departureDate)!,
                    );
                  },
                  separatorBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Divider(
                      color: Colors.white,
                    ),
                  ),
                );
              } //fim do else
            },
          ),
        ),
      ),
    );
  }
}
