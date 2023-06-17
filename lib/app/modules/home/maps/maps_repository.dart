import 'package:maps/app/core/database/models/contact_repository.dart';
import 'package:maps/app/core/database/models/fav_place_repository.dart';
import 'package:maps/app/core/models/fav_place.dart';
import 'package:maps/app/core/services/secure_storage.dart';

import '../../../core/models/contact.dart';

class MapsRepository {
  final ContactRepository repository;
  final FavoritePlaceRepository repositoryPlace;
  final SecureStorage storage;
  MapsRepository(this.repository, this.storage, this.repositoryPlace);

  Future<Contact?> searchContacts(String name) async {
    final userId = await storage.read('user_id');
    final List<Contact> contact =
        await repository.getContactsFromUserAndName(userId, name);
    if (contact.isNotEmpty) {
      return contact[0];
    }
    return null;
  }

  Future<List<FavoritePlace>> listenFavoritePlaces() async {
    final userId = await storage.read('user_id');

    final List<FavoritePlace> places =
        await repositoryPlace.getplacesFromUser(userId);
    if (places.isEmpty) {
      return [];
    }
    return places;
  }

  Future<List<Contact>> searchAllContacts() async {
    final userId = await storage.read('user_id');
    final List<Contact> contact = await repository.getAllContacts(userId!);
    if (contact.isEmpty) {
      return [];
    }
    return contact;
  }

  Future<FavoritePlace?> detailPlaceFromNameandUser(String name) async {
    final userId = await storage.read('user_id');
    final place =
        await repositoryPlace.detailPlaceFromNameandUser(userId!, name);
    if (place != null) {
      return place;
    }
    return null;
  }
}
