import 'package:maps/app/core/database/models/contact_repository.dart';
import 'package:maps/app/core/services/secure_storage.dart';

import '../../../core/models/contact.dart';

class MapsRepository {
  final ContactRepository repository;
  final SecureStorage storage;
  MapsRepository(this.repository, this.storage);

  Future<Contact?> searchContacts() async {
    final userId = await storage.read('user_id');
    final List<Contact> contact = await repository.getContactsFromUser(userId);
    if (contact.isNotEmpty) {
      return contact[0];
    }
    return null;
  }
}
