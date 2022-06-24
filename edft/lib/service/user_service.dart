// ignore_for_file: avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edft/localization/localization_service.dart';
import 'package:edft/models/app_user.dart';
import 'package:edft/providers/app_user_provider.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:provider/provider.dart';

class UserService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AppUser> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _collection.doc(currentUser.uid).get();
    Map<String, dynamic> userJson = snap.data() as Map<String, dynamic>;
    AppUser user = AppUser.fromMap(userJson);
    return user;
  }

  String getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

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
      _createUser(cred.user!.uid, cred.user!.email!, name, avatarUrl);
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

  //We refresh user after updates and popping screens so we make sure we always have the most up to date information
  Future<void> refreshUser(BuildContext context) async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  Future<void> _createUser(
      String id, String email, String name, String? avatarUrl) async {
    AppUser user =
        AppUser(id: id, email: email, name: name, avatarUrl: avatarUrl);
    await _collection.doc(id).set(AppUser.toMap(user));
  }

  Future<void> updateUser(AppUser user, BuildContext context) async {
    await _collection.doc(user.id).set(AppUser.toMap(user));
    refreshUser(context);
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "success";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (err) {
      var errorCode = err.code;
      if (errorCode == 'invalid-email') {
        res = LocalizationService.instance.getLocalizedString("invalid_email");
      } else if (errorCode == 'user-not-found') {
        res = LocalizationService.instance.getLocalizedString("user_not_found");
      } else if (errorCode == 'wrong-password') {
        res = LocalizationService.instance.getLocalizedString("wrong_password");
      } else {
        res = LocalizationService.instance.getLocalizedString("unknown_error");
      }
    }
    return res;
  }

  Future<String> resetPassword({required String email}) async {
    String res = "success";
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (err) {
      var errorCode = err.code;
      if (errorCode == 'invalid-email') {
        res = LocalizationService.instance.getLocalizedString("invalid_email");
      } else if (errorCode == 'user-not-found') {
        res = LocalizationService.instance.getLocalizedString("user_not_found");
      }
    }
    return res;
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
