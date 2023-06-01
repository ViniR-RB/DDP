import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/home/components/card_contact.dart';

import '../../../core/models/contact.dart';
import '../components/button_sheet.dart';
import '../home_controller.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final _controller = Modular.get<HomeController>();
  @override
  void initState() {
    _controller.fetchContacts();
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
        title: const Text('Todos os contatos'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller.contact,
        builder: (BuildContext context, List<Contact> value, Widget? child) {
          return value.isEmpty
              ? const Center(
                  child: Text('Crie Agora Mesmo Seus Contatos'),
                )
              : ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return CardContact(
                        initialName: value[index].name[0],
                        title: value[index].name,
                        onTap: () async {
                          Modular.to.pushNamed('/home/detailContactPage',
                              arguments: {'contact': value[index]});
                          // Navigator.pushNamed(
                          //   context,
                          //   DetailContactPage.routeName,
                          //   arguments: Contact(
                          //     id: value[index].id,
                          //     name: value[index].name,
                          //     userId: value[index].userId,
                          //     latitude: value[index].latitude,
                          //     longitude: value[index].longitude,
                          //   ),
                          // );
                        });
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async =>
            await CustomButtonSheetContact.showModalBottomSheetCustom(
                context, _controller),
        child: const Text(
          '+',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
