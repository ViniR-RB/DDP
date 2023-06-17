import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/models/fav_place.dart';
import 'package:maps/app/modules/home/components/place_update_buttom_sheet.dart';
import 'package:maps/app/modules/home/places/place_controller.dart';

class DetailPlacePage extends StatefulWidget {
  final dynamic args;
  const DetailPlacePage({super.key, required this.args});

  @override
  State<DetailPlacePage> createState() => _DetailPlacePageState();
}

class _DetailPlacePageState extends State<DetailPlacePage> {
  final _controller = Modular.get<PlacesController>();
  late FavoritePlace data;

  void _editContact() async {
    await CustomButtonSheetPlaceDetail.showModalBottomSheetDetail(
      context,
      _controller,
      initialid: data.id,
      initialName: data.name,
      initialPhone: data.phone,
      initialAddress: data.address,
      initialsocialmidia: data.socialmidia,
      initialdescription: data.description,
    );
  }

  @override
  void initState() {
    data = widget.args['place'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            color: Colors.cyan,
            iconSize: 26,
            onPressed: _editContact,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            color: Colors.redAccent,
            iconSize: 26,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirmar exclusão'),
                    content: const Text(
                        'Tem certeza que deseja excluir este lugar?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Modular.to.pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Excluir'),
                        onPressed: () {
                          _controller.repository.deletePlace(data.id);
                          Modular.to.pushNamed('/home/favoritePlacesPage');
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
        leading: IconButton(
            onPressed: () => Modular.to.pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.indigo[800],
            )),
        title: const Text('Lugar favorito'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  child: Text(data.name[0].toUpperCase(),
                      style: const TextStyle(fontSize: 32)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ver como não quebrar a linha para nomes grandes
              Text(
                data.name,
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Telefone: ${data.phone}',
                style: const TextStyle(
                  fontSize: 27,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    data.address!,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Rede Social: ${data.socialmidia}',
            style: const TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Descrição: ${data.description}',
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
