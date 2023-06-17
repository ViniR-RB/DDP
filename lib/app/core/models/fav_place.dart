import 'dart:convert';

class FavoritePlace {
  final String id;
  late String name;
  late String userId;
  late String phone;
  late String? address;
  late String? socialmidia;
  late String? description;
  late double? latitude;
  late double? longitude;
  FavoritePlace({
    required this.id,
    required this.name,
    required this.userId,
    required this.phone,
    this.address,
    this.socialmidia,
    this.description,
    this.latitude,
    this.longitude,
  });

  FavoritePlace copyWith({
    String? id,
    String? name,
    String? userId,
    String? phone,
    String? address,
    String? socialmidia,
    String? description,
    double? latitude,
    double? longitude,
  }) {
    return FavoritePlace(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      socialmidia: socialmidia ?? this.socialmidia,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'socialmidia': socialmidia,
      'description': description,
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory FavoritePlace.fromMap(Map<String, dynamic> map) {
    return FavoritePlace(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      socialmidia: map['socialmidia'] as String,
      description: map['description'] as String,
      userId: map['user_id'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoritePlace.fromJson(String source) =>
      FavoritePlace.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FavoritePlace(id: $id, name: $name,phone: $phone, address: $address, socialmidia: $socialmidia, description: $description, userId: $userId, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant FavoritePlace other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.socialmidia == socialmidia &&
        other.description == description &&
        other.userId == userId &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        socialmidia.hashCode ^
        description.hashCode ^
        userId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
