import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/home/components/card_contact.dart';

import '../components/button_sheet.dart';
import '../home_controller.dart';

class ContactsPage extends StatelessWidget {
  ContactsPage({super.key});
  final _controller = Modular.get<HomeController>();

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
      body: ListView(
        children: [CardContact(title: 'Amor', onTap: () async {})],
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
