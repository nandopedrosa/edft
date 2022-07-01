class Attraction {
  final String id;
  final String name;
  final String countryCode;
  final String cityId;
  final String category;
  final String budget;
  final String latitude;
  final String longitude;
  final String address;
  final String image;
  final String description;
  final String url;
  bool? isAdded;
  String? distanceToStayLocation;

  Attraction(
      {required this.id,
      required this.name,
      required this.countryCode,
      required this.cityId,
      required this.category,
      required this.budget,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.image,
      required this.description,
      required this.url});

  static Map<String, dynamic> toMap(Attraction a) {
    final Map<String, dynamic> attractionMap = {};
    attractionMap['id'] = a.id;
    attractionMap['name'] = a.name;
    attractionMap['countryCode'] = a.countryCode;
    attractionMap['cityId'] = a.cityId;
    attractionMap['category'] = a.category;
    attractionMap['budget'] = a.budget;
    attractionMap['latitude'] = a.latitude;
    attractionMap['longitude'] = a.longitude;
    attractionMap['address'] = a.address;
    attractionMap['image'] = a.image;
    attractionMap['description'] = a.description;
    attractionMap['url'] = a.url;
    return attractionMap;
  }

  factory Attraction.fromMap(Map<String, dynamic> map) => Attraction(
        id: map['id'],
        name: map['name'],
        countryCode: map['countryCode'],
        cityId: map['cityId'],
        category: map['category'],
        budget: map['budget'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        address: map['address'],
        image: map['image'],
        description: map['description'],
        url: map['url'],
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Attraction && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
