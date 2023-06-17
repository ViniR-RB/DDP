import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/models/fav_place.dart';
import 'package:maps/app/modules/home/places/places_repository.dart';

import '../../../app_controller.dart';
import '../../../core/models/user.dart';

class PlacesController {
  final PlacesRepository repository;
  final AppController controller;

  ValueNotifier<User> user = ValueNotifier(
      User(id: 'id', name: 'name', email: 'email', password: 'password'));
  ValueNotifier<List<FavoritePlace>> place = ValueNotifier([]);

  PlacesController(
    this.controller,
    this.repository,
  );

  Future<void> whoIsMyUser() async {
    user.value = await controller.howMyUser();
  }

  Future<void> createPlace(String name, String phone, String address,
      String? socialmidia, String? description) async {
    await repository.createPlace(
        name, phone, address, socialmidia, description);
  }

  Future<void> fetchPlaces() async {
    place.value = await repository.fetchPlaces();
  }

  Future<void> logout() async {
    await repository.delete();
    Modular.to.navigate('/login');
  }

  Future<FavoritePlace?> detailPlace(String id) async {
    final FavoritePlace? detailPlace = await repository.detailPlace(id);
    return detailPlace;
  }

  Future<void> updatePlace(FavoritePlace updplace) async {
    await repository.updatePlace(updplace);
  }

  Future<void> deletePlace(String id) async {
    await repository.deletePlace(id);
  }
}
