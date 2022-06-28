// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/providers/travel_provider.dart';
import 'package:edft/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TravelService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('travels');

  CollectionReference getCollection() {
    return _collection;
  }

  Future<Travel> getTravelDetails(String travelId) async {
    DocumentSnapshot snap = await _collection.doc(travelId).get();
    Map<String, dynamic> travelMap = snap.data() as Map<String, dynamic>;
    Travel travel = Travel.fromMap(travelMap);
    return travel;
  }

  //We refresh user after updates and popping screens so we make sure we always have the most up to date information
  Future<void> refreshTravel(BuildContext context, String? travelId) async {
    if (travelId != null) {
      TravelProvider userProvider = Provider.of(context, listen: false);
      await userProvider.refreshTravel(travelId);
    }
  }

  Future<void> updateTravel(Travel travel, BuildContext context) async {
    if (travel.userId == null || travel.userId!.isEmpty) {
      travel.userId = UserService().getCurrentUserId();
    }

    if (travel.id == null) {
      //New travel
      DocumentReference doc = _collection.doc(); //First, create the document
      travel.id = doc.id;
      doc.set(Travel.toMap(travel));
    } else {
      //Existing travel
      await _collection.doc(travel.id).set(Travel.toMap(travel));
    }
    refreshTravel(context, travel.id!);
  }

  Future<void> addOrRemoveAttraction(
      {required String travelId,
      required String attractionId,
      required bool isAdded,
      required BuildContext context}) async {
    if (!isAdded) {
      //Add
      await _collection.doc(travelId).update({
        'attractions': FieldValue.arrayUnion([attractionId])
      });
    } else {
      //Remove
      await _collection.doc(travelId).update({
        'attractions': FieldValue.arrayRemove([attractionId])
      });
    }
    refreshTravel(context, travelId);
  }
}
