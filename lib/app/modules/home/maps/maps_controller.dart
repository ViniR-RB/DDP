import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/app/core/models/contact.dart';

import 'maps_repository.dart';

class MapsController {
  final MapsRepository repository;
  GoogleMapController? mapController;
  ValueNotifier<Contact> contact = ValueNotifier(Contact(
      id: 'id',
      latitude: 0,
      longitude: 0,
      addres: 'address',
      name: 'name',
      userId: 'user_id',
      phone: '0'));

  MapsController(this.repository);

  Future<void> searchContacts() async {
    final result = await repository.searchContacts();

    if (result != null) {
      contact.value = result;
      selectContact(contact.value);
    }
  }

  void selectContact(Contact contact) async {
    moveCameraToLocation(contact.latitude, contact.longitude);
  }

  Future<void> moveCameraToLocation(double latitude, double longitude) async {
    if (mapController != null) {
      LatLng latLng = LatLng(latitude, longitude);
      CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 15);
      mapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }
}
