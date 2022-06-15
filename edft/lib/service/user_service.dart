// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/localization/localization_service.dart';
import 'package:edft/models/app_user.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';

class UserService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signupUser({
    required String name,
    required String email,
    required String password,
    Uint8List? avatar,
  }) async {
    String res = "success";
    try {
      //Signup (Auth)
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //Upload image to storage (avatar)
      String? avatarUrl;

      if (avatar != null) {
        avatarUrl = await StorageMethods()
            .uploadImageToStorage(avatarFolder, cred.user!.uid, avatar);
      }
      //Create User (Doc)
      createUser(cred.user!.uid, name, avatarUrl);
    } on FirebaseAuthException catch (err) {
      var errorCode = err.code;
      if (errorCode == 'email-already-in-use') {
        res = LocalizationService.instance
            .getLocalizedString("email_already_in_use");
      } else if (errorCode == 'invalid-email') {
        res = LocalizationService.instance.getLocalizedString("invalid_email");
      } else if (errorCode == 'weak-password') {
        res = LocalizationService.instance.getLocalizedString("weak_password");
      } else {
        res = LocalizationService.instance.getLocalizedString("unknown_error");
      }
    }
    return res;
  }

  Future<void> createUser(String id, String name, String? avatarUrl) async {
    AppUser user = AppUser(id: id, name: name, avatarUrl: avatarUrl);
    await _collection.doc(id).set(AppUser.toJson(user));
  }
}
