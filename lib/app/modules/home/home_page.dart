import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/home/home_controller.dart';

import 'components/card_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
                onPressed: () async {
                  await controller.logout();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            CardCategory(
              onTap: () => Modular.to.pushNamed('/home/contacts'),
              title: 'Contatos',
              subTitle: 'Adicione seus Contatos Mais Proximos',
              leading: Icons.people,
            ),
            CardCategory(
              title: 'Mapas',
              subTitle: 'Veja os contatos Adicionandos no Mapa',
              leading: Icons.maps_home_work,
              onTap: () => Modular.to.pushNamed('/home/maps'),
            ),
            CardCategory(
              title: 'Profile',
              subTitle: 'Veja Seu Perfil',
              leading: Icons.abc,
              onTap: () => Modular.to.pushNamed('/home/profile'),
            ),
          ],
        ));
  }
}
