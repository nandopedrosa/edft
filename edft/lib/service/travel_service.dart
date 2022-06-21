// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/providers/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TravelService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('travels');

  Future<Travel> getTravelDetails(String travelId) async {
    DocumentSnapshot snap = await _collection.doc(travelId).get();
    Map<String, dynamic> travelMap = snap.data() as Map<String, dynamic>;
    Travel travel = Travel.fromMap(travelMap);
    return travel;
  }

  Future<void> updateTravel(Travel travel, BuildContext context) async {
    if (travel.id == null) {
      //New travel
      DocumentReference doc = _collection.doc(); //First, create the document
      travel.id = doc.id;
      doc.set(Travel.toMap(travel));
    } else {
      //Existing travel
      await _collection.doc(travel.id).set(Travel.toMap(travel));
    }
    TravelProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshTravel(travel.id!);
  }
}
