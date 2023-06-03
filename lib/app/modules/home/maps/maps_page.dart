import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/app/modules/home/maps/maps_controller.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => MapSampleState();
}

class MapSampleState extends State<MapsPage> {
  final TextEditingController _searchController = TextEditingController();
  final MapsController mapscontroller = Modular.get<MapsController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.name,
                onChanged: (search) async {
                  await mapscontroller.searchContacts(search);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Digite um nome de um usuário')),
          ),
        ),
        body: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: mapscontroller.contact,
              builder: (context, value, child) {
                return GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0), // Posição inicial do mapa
                    zoom: 10,
                  ),
                  onMapCreated: (controller) {
                    mapscontroller.mapController = controller;
                  },
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId(value.name),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure),
                      infoWindow: InfoWindow(
                        title: value.name,
                        snippet: value.phone,
                      ),
                      position: LatLng(
                        value.latitude,
                        value.longitude,
                      ),
                    ),
                  },
                );
              },
            )
          ],
        ));
  }
}
