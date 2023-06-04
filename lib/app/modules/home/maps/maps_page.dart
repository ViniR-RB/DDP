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
    mapscontroller.searchAllContacts();
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
                    prefixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(),
                    labelText: 'Digite um nome de um usuário')),
          ),
        ),
        body: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: mapscontroller.markers,
              builder: (context, value, child) {
                return GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0), // Posição inicial do mapa
                    zoom: 10,
                  ),
                  onMapCreated: (controller) {
                    mapscontroller.mapController = controller;
                  },
                  markers: mapscontroller.markers.value,
                );
              },
            )
          ],
        ));
  }
}
