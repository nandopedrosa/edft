// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/models/app_user.dart';

class UserService {
  static final CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');

  // static List<AppUser> readUsers() {
  //   List<AppUser> users = [];
  //   DocumentSn_collection.doc().get();
  //   Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

  //   return users;
  // }

  static Future<bool> checkIfUserExists(String email) async {
    bool result = false;
    QuerySnapshot snapshots =
        await _collection.where("email", isEqualTo: email.toLowerCase()).get();
    snapshots.size == 0 ? result = false : result = true;
    return result;
  }

  static Future createUser(String name, String email, String password) async {
    final docUser = _collection.doc();
    AppUser user = AppUser(
      id: docUser.id,
      name: name,
      email: email.toLowerCase(),
      password: password,
    );
    await docUser.set(AppUser.toJson(user));
  }
}
