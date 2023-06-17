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
  bool searchIsContact = true;
  @override
  void initState() {
    mapscontroller.listenAllMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.people),
              onPressed: () {
                setState(() {
                  searchIsContact = true;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.location_city),
              onPressed: () {
                setState(() {
                  searchIsContact = false;
                });
              },
            )
          ],
          title: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: searchIsContact == true
                ? TextField(
                    controller: _searchController,
                    keyboardType: TextInputType.name,
                    onChanged: (search) async {
                      await mapscontroller.searchContacts(search);
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        hintText: 'Procurar Contato'))
                : TextField(
                    controller: _searchController,
                    keyboardType: TextInputType.name,
                    onChanged: (search) async {
                      await mapscontroller.searchPlaceFromNameandUser(search);
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        hintText: 'Procuar Lugar')),
          ),
        ),
        body: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: mapscontroller.markers,
              builder: (context, value, child) {
                return GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(-5.092350767257616,
                        -42.79740389435981), // Posição inicial do mapa
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
