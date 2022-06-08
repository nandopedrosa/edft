class Country {
  String code;
  String name;

  Country({
    required this.code,
    required this.name,
  });

  static Map<String, dynamic> toMap(Country country) {
    final Map<String, dynamic> countryMap = {};
    countryMap['code'] = country.code;
    countryMap['name'] = country.name;
    return countryMap;
  }

  factory Country.fromMap(Map<String, dynamic> json) => Country(
        code: json["code"],
        name: json["name"],
      );

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}

class City {
  String id;
  String countryCode;
  String name;

  City({
    required this.id,
    required this.countryCode,
    required this.name,
  });

  static Map<String, dynamic> toMap(City city) {
    final Map<String, dynamic> cityMap = {};
    cityMap['id'] = city.id;
    cityMap['countryCode'] = city.countryCode;
    cityMap['name'] = city.name;
    return cityMap;
  }

  factory City.fromMap(Map<String, dynamic> json) => City(
        id: json['id'],
        countryCode: json["countryCode"],
        name: json["name"],
      );

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is City && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Attraction {
  final String code;
  final String name;
  final String image;

  Attraction({
    required this.code,
    required this.name,
    required this.image,
  });

  @override
  String toString() {
    return name;
  }
}
