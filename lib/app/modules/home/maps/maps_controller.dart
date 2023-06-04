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
  ValueNotifier<Set<Marker>> markers = ValueNotifier(<Marker>{});

  MapsController(this.repository);

  Future<void> searchContacts(String name) async {
    final result = await repository.searchContacts(name);

    if (result != null) {
      contact.value = result;
      selectContact(contact.value);
    }
  }

  void selectContact(Contact contact) async {
    moveCameraToLocation(contact.latitude, contact.longitude);
    markers.value.add(Marker(
        markerId: MarkerId(
          contact.id,
        ),
        position: LatLng(contact.latitude, contact.longitude),
        infoWindow: InfoWindow(snippet: contact.phone, title: contact.name)));
  }

  Future<void> moveCameraToLocation(double latitude, double longitude) async {
    if (mapController != null) {
      LatLng latLng = LatLng(latitude, longitude);
      CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 15);

      mapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  Future<void> searchAllContacts() async {
    final result = await repository.searchAllContacts();
    result
        .map(
          (e) => markers.value.add(
            Marker(
                markerId: MarkerId(e.id),
                position: LatLng(e.latitude, e.longitude),
                infoWindow: InfoWindow(snippet: e.phone, title: e.name)),
          ),
        )
        .toList();
    print(markers.value);
  }
}
