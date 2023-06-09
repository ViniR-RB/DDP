import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/models/contact.dart';
import 'package:maps/app/modules/home/home_controller.dart';

import '../components/detail_button_sheet.dart';

class DetailContactPage extends StatefulWidget {
  final dynamic args;
  const DetailContactPage({super.key, required this.args});

  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  final _controller = Modular.get<HomeController>();
  late Contact data;

  void _editContact() async {
    await CustomButtonSheetDetail.showModalBottomSheetDetail(
      context,
      _controller,
      initialid: data.id,
      initialName: data.name,
      initialPhone: data.phone,
      initialAddress: data.addres,
    );
  }

  @override
  void initState() {
    data = widget.args['contact'];
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
                        'Tem certeza que deseja excluir este contato?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Excluir'),
                        onPressed: () {
                          _controller.repository.deleteContact(data.id);
                          Modular.to.pushNamed('/home/contacts');
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
        title: const Text('Seu contato'),
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
                    data.addres,
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
        ],
      ),
    );
  }
}
