import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/models/attraction.dart';

class AttractionService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('attractions');

  CollectionReference getCollection() {
    return _collection;
  }

  Future<Attraction> getAttractionDetails(String attractionId) async {
    DocumentSnapshot snap = await _collection.doc(attractionId).get();
    Map<String, dynamic> attractionMap = snap.data() as Map<String, dynamic>;
    Attraction attraction = Attraction.fromMap(attractionMap);
    return attraction;
  }
}
