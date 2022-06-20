import 'package:edft/utils/functions.dart';
import 'package:edft/utils/models.dart';

class AppUser {
  String id;
  String email;
  String name;
  String? avatarUrl;
  String? yearOfBirth;
  String? gender;
  String? relationShipStatus;
  Country? country;
  String? preferenceAccomodation;
  String? preferenceTransport;
  String? preferenceBudget;
  List? preferenceAttractions;

  AppUser(
      {required this.id,
      required this.email,
      required this.name,
      this.avatarUrl,
      this.yearOfBirth,
      this.gender,
      this.relationShipStatus,
      this.country,
      this.preferenceAccomodation,
      this.preferenceTransport,
      this.preferenceBudget,
      this.preferenceAttractions});

  static Map<String, dynamic> toJson(AppUser appUser) {
    final Map<String, dynamic> appUserMap = {};
    appUserMap['id'] = appUser.id;
    appUserMap['email'] = appUser.email;
    appUserMap['name'] = appUser.name;
    appUserMap['avatarUrl'] = appUser.avatarUrl;
    appUserMap['yearOfBirth'] = appUser.yearOfBirth;
    appUserMap['gender'] = appUser.gender;
    appUserMap['relationShipStatus'] = appUser.relationShipStatus;
    appUserMap['country'] = appUser
        .country?.code; //Returns value if not null. Otherwise, returns null
    appUserMap['preferenceAccomodation'] = appUser.preferenceAccomodation;
    appUserMap['preferenceTransport'] = appUser.preferenceTransport;
    appUserMap['preferenceBudget'] = appUser.preferenceBudget;
    appUserMap['preferenceAttractions'] = appUser.preferenceAttractions;
    return appUserMap;
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      avatarUrl: json["avatarUrl"],
      yearOfBirth: json["yearOfBirth"],
      gender: json["gender"],
      relationShipStatus: json["relationShipStatus"],
      country: getCountryFromCode(json["country"]),
      preferenceAccomodation: json['preferenceAccomodation'],
      preferenceTransport: json['preferenceTransport'],
      preferenceBudget: json['preferenceBudget'],
      preferenceAttractions: json['preferenceAttractions']);

  void addAttraction(String attractionCode) {
    preferenceAttractions ??= [];
    preferenceAttractions!.add(attractionCode);
  }

  @override
  String toString() {
    return email;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppUser && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
