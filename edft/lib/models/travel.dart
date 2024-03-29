import 'package:edft/localization/localization_service.dart';
import 'package:edft/models/attraction.dart';
import 'package:edft/service/attraction_service.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/models.dart';

class Travel {
  String? id;
  String? userId;
  String? name;
  String? numberOfTravelers;
  String? arrivalDate; //iso 8601 format
  String? departureDate; //iso 8601 format
  String? transportCode;
  String? accomodationCode;
  String? countryCode;
  String? cityId;
  String? stayMapsId;
  String? stayName;
  String? stayAddress;
  String? stayLat;
  String? stayLng;
  List attractions = []; //List of attraction ID's

  Travel.empty();

  Travel(
      {required this.id,
      required this.userId,
      required this.name,
      required this.numberOfTravelers,
      required this.arrivalDate,
      required this.departureDate,
      required this.transportCode,
      required this.accomodationCode,
      required this.countryCode,
      required this.cityId,
      required this.stayMapsId,
      required this.stayName,
      required this.stayAddress,
      required this.stayLat,
      required this.stayLng,
      required this.attractions});

  static Map<String, dynamic> toMap(Travel travel) {
    final Map<String, dynamic> travelMap = {};
    travelMap['id'] = travel.id;
    travelMap['userId'] = travel.userId;
    travelMap['name'] = travel.name;
    travelMap['numberOfTravelers'] = travel.numberOfTravelers;
    travelMap['arrivalDate'] = travel.arrivalDate;
    travelMap['departureDate'] = travel.departureDate;
    travelMap['transportCode'] = travel.transportCode;
    travelMap['accomodationCode'] = travel.accomodationCode;
    travelMap['countryCode'] = travel.countryCode;
    travelMap['cityId'] = travel.cityId;
    travelMap['stayMapsId'] = travel.stayMapsId;
    travelMap['stayName'] = travel.stayName;
    travelMap['stayAddress'] = travel.stayAddress;
    travelMap['stayLat'] = travel.stayLat;
    travelMap['stayLng'] = travel.stayLng;
    travelMap['attractions'] = travel.attractions;
    return travelMap;
  }

  factory Travel.fromMap(Map<String, dynamic> travelMap) => Travel(
        id: travelMap["id"],
        userId: travelMap["userId"],
        name: travelMap["name"],
        numberOfTravelers: travelMap["numberOfTravelers"],
        arrivalDate: travelMap["arrivalDate"],
        departureDate: travelMap["departureDate"],
        transportCode: travelMap["transportCode"],
        accomodationCode: travelMap["accomodationCode"],
        countryCode: travelMap["countryCode"],
        cityId: travelMap["cityId"],
        stayMapsId: travelMap["stayMapsId"],
        stayName: travelMap["stayName"],
        stayAddress: travelMap["stayAddress"],
        stayLat: travelMap["stayLat"],
        stayLng: travelMap["stayLng"],
        attractions: travelMap["attractions"],
      );

  Country? getCountry() {
    List<Country> countries =
        LocalizationService.instance.getPreferredLanguage() == 'pt'
            ? countriesPt
            : countriesEn;
    for (Country c in countries) {
      if (c.code == countryCode) {
        return c;
      }
    }
    return null;
  }

  City? getCity() {
    List<City> cities =
        LocalizationService.instance.getPreferredLanguage() == 'pt'
            ? citiesPt
            : citiesEn;
    for (City c in cities) {
      if (c.id == cityId) {
        return c;
      }
    }
    return null;
  }

  Future<List<Attraction>> getAttractions() async {
    List<Attraction> res = [];
    for (String id in attractions) {
      Attraction a = await AttractionService().getAttractionDetails(id);
      res.add(a);
    }
    return res;
  }

  @override
  String toString() {
    return name ?? "";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Travel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
