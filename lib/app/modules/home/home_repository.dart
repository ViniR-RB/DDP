import 'package:maps/app/core/database/models/contact_repository.dart';
import 'package:maps/app/core/models/contact.dart';
import 'package:maps/app/core/services/geocoding.dart';
import 'package:maps/app/core/services/secure_storage.dart';
import 'package:uuid/uuid.dart';

class HomeRepository {
  final GeoCodingService geoCoding;
  final SecureStorage storage;
  final ContactRepository repository;
  HomeRepository(this.geoCoding, this.repository, this.storage);

  Future<void> createContact(String nome, String phone, String address) async {
    final locations = await geoCoding.searchFromAddress(address);

    if (locations != null) {
      final userId = await storage.read("user_id");
      final Contact contact = Contact(
        id: const Uuid().v4(),
        name: nome,
        userId: userId!,
        latitude: locations['latitude'],
        longitude: locations['longitude'],
      );
      print(locations);
      /*   repository.inserContact(contact); */
    }
  }
}
