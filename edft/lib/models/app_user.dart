import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String id;
  String name;
  String email;
  String? password;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.password,
  });

  static Map<String, dynamic> toJson(AppUser appUser) {
    final Map<String, dynamic> appUserMap = {};
    appUserMap['id'] = appUser.id;
    appUserMap['name'] = appUser.name;
    appUserMap['email'] = appUser.email;
    appUserMap['password'] = appUser.password;
    return appUserMap;
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  @override
  String toString() {
    return email;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppUser && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
