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

class Attraction {
  final String code;
  final String name;

  Attraction({
    required this.code,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }
}
