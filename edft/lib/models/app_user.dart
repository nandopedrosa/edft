class AppUser {
  String id;
  String name;
  String? avatarUrl;

  AppUser({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  static Map<String, dynamic> toJson(AppUser appUser) {
    final Map<String, dynamic> appUserMap = {};
    appUserMap['id'] = appUser.id;
    appUserMap['name'] = appUser.name;
    appUserMap['avatarUrl'] = appUser.avatarUrl;
    return appUserMap;
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json["id"],
        name: json["name"],
        avatarUrl: json["avatarUrl"],
      );

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppUser && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
