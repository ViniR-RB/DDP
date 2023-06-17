import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/models/fav_place.dart';
import 'package:maps/app/modules/home/components/card_contact.dart';
import 'package:maps/app/modules/home/places/add_place.dart';
import 'package:maps/app/modules/home/places/place_controller.dart';

class FavoritePlacesPage extends StatefulWidget {
  const FavoritePlacesPage({
    super.key,
  });

  @override
  State<FavoritePlacesPage> createState() => _FavoritePlacesPageState();
}

class _FavoritePlacesPageState extends State<FavoritePlacesPage> {
  final _controller = Modular.get<PlacesController>();
  @override
  void initState() {
    _controller.fetchPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [],
        leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.indigo[800],
            )),
        title: const Text('Lugares Favoritos'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller.place,
        builder:
            (BuildContext context, List<FavoritePlace> value, Widget? child) {
          return value.isEmpty
              ? const Center(
                  child: Text('Adicione seus lugares favoritos'),
                )
              : ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return CardContact(
                        initialName: value[index].name[0],
                        title: value[index].name,
                        onTap: () async {
                          Modular.to.pushNamed('/home/detailPlacetPage',
                              arguments: {'place': value[index]});
                        });
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFavoritePlace(),
            ),
          );
        },
        child: const Icon(Icons.add_business_outlined),
      ),
    );
  }
}
