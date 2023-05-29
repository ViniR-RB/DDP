// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Contact {
  final int id;
  final String name;
  final int userId;
  final double latitude;
  final double longitude;
  Contact({
    required this.id,
    required this.name,
    required this.userId,
    required this.latitude,
    required this.longitude,
  });

  Contact copyWith({
    int? id,
    String? name,
    int? userId,
    double? latitude,
    double? longitude,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as int,
      name: map['name'] as String,
      userId: map['user_id'] as int,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, userId: $userId, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.userId == userId &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}