import 'package:edft/localization/localization_service.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/models.dart';

class Travel {
  String? id;
  String? name;
  String? numberOfTravelers;
  String? arrivalDate; //iso 8601 format
  String? departureDate; //iso 8601 format
  String? transportCode;
  String? accomodationCode;
  String? countryCode;
  String? cityId;

  Travel.empty();

  Travel(
      {required this.id,
      required this.name,
      required this.numberOfTravelers,
      required this.arrivalDate,
      required this.departureDate,
      required this.transportCode,
      required this.accomodationCode,
      required this.countryCode,
      required this.cityId});

  static Map<String, dynamic> toMap(Travel travel) {
    final Map<String, dynamic> travelMap = {};
    travelMap['id'] = travel.id;
    travelMap['name'] = travel.name;
    travelMap['numberOfTravelers'] = travel.numberOfTravelers;
    travelMap['arrivalDate'] = travel.arrivalDate;
    travelMap['departureDate'] = travel.departureDate;
    travelMap['transportCode'] = travel.transportCode;
    travelMap['accomodationCode'] = travel.accomodationCode;
    travelMap['countryCode'] = travel.countryCode;
    travelMap['cityId'] = travel.cityId;
    return travelMap;
  }

  factory Travel.fromMap(Map<String, dynamic> json) => Travel(
        id: json["id"],
        name: json["name"],
        numberOfTravelers: json["numberOfTravelers"],
        arrivalDate: json["arrivalDate"],
        departureDate: json["departureDate"],
        transportCode: json["transportCode"],
        accomodationCode: json["accomodationCode"],
        countryCode: json["countryCode"],
        cityId: json["cityId"],
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
