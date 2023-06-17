import 'package:maps/app/core/database/models/fav_place_repository.dart';
import 'package:maps/app/core/models/fav_place.dart';
import 'package:maps/app/core/services/geocoding.dart';
import 'package:maps/app/core/services/secure_storage.dart';
import 'package:uuid/uuid.dart';


class PlacesRepository {
  final GeoCodingService geoCoding;
  final SecureStorage storage;
  final FavoritePlaceRepository repository;
  PlacesRepository(this.geoCoding, this.repository, this.storage);

  Future<void> createPlace(String name, String phone, String address,
      String? socialmidia, String? description) async {
    final locations = await geoCoding.searchFromAddress(address);

    if (locations != null) {
      final userId = await storage.read("user_id");
      final FavoritePlace place = FavoritePlace(
        id: const Uuid().v4(),
        name: name,
        userId: userId!,
        phone: phone,
        address: address,
        socialmidia: socialmidia,
        description: description,
        latitude: locations['latitude'],
        longitude: locations['longitude'],
      );

      await repository.inserPlace(place);
    }
  }

  Future<List<FavoritePlace>> fetchPlaces() async {
    final userId = await storage.read("user_id");
    return await repository.getplacesFromUser(userId);
  }

  Future<void> delete() async {
    await storage.delete('user_id');
  }

  Future<FavoritePlace?> detailPlace(String id) async {
    return await repository.detailPlace(id);
  }

  Future<void> updatePlace(FavoritePlace? updplace) async {
    await repository.updatePlace(updplace!);
  }

  Future<void> deletePlace(String id) async {
    await repository.deletePlace(id);
  }
}
