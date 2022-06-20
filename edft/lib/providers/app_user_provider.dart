import 'package:edft/models/app_user.dart';
import 'package:edft/service/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AppUser? _user;

  AppUser get getUser => _user!;

  Future<void> refreshUser() async {
    // Here we are getting the most up-to-date user from the Database
    // We could pass a copy to this method to refresh the user in memory, so we don't have to access the DB every time
    _user = await UserService().getUserDetails();
    notifyListeners();
  }
}
