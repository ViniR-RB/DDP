import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => MapSampleState();
}

class MapSampleState extends State<MapsPage> {
  final Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
    setMaker();
  }

  setMaker() {
    _markers.add(Marker(
      markerId: const MarkerId('marker_1'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      position: const LatLng(-5.167847387698618, -42.79171416931178),
      infoWindow: const InfoWindow(
        title: 'Casa',
        snippet: 'Minha Casa',
      ),
    ));
    GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(37.4220, -122.0841),
        zoom: 10,
      ),
      markers: _markers,
    );
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static const CameraPosition _home = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-5.167847387698618, -42.79171416931178),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Maps")),
        body: GoogleMap(
          mapType: MapType.normal,
          markers: _markers,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: Container(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton.extended(
            tooltip: 'Ir para Casa',
            onPressed: _goToTheHome,
            isExtended: true,
            label: const Text('Go to Home'),
            icon: const Icon(Icons.home),
          ),
        ));
  }

  Future<void> _goToTheHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_home));
  }
}
