// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Contact {
  final String id;
  final String name;
  final String userId;
  final String phone;
  final String addres;
  final double latitude;
  final double longitude;
  Contact({
    required this.id,
    required this.name,
    required this.userId,
    required this.phone,
    required this.addres,
    required this.latitude,
    required this.longitude,
  });

  Contact copyWith({
    String? id,
    String? name,
    String? userId,
    String? phone,
    String? addres,
    double? latitude,
    double? longitude,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      phone: phone ?? this.phone,
      addres: addres ?? this.addres,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'address': addres,
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      userId: map['user_id'] as String,
      addres: map['addres'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(id: $id, name: $name,phone: $phone, addres: $addres userId: $userId, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.userId == userId &&
        other.phone == phone &&
        other.addres == addres &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        phone.hashCode ^
        addres.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
