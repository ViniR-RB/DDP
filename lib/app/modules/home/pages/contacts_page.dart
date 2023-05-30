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
        title: const Text('Profile Page'),
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
                        onTap: () async {});
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
