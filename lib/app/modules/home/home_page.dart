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
            Container(
              // width: 150,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage('assets/logoifpi.png'),
                ),
              ),
            ),
            CardCategory(
              onTap: () => Modular.to.pushNamed('/home/contacts'),
              title: 'Contatos',
              subTitle: 'Adicione seus Contatos Mais Proximos',
              leading: Icons.people,
            ),
            CardCategory(
              onTap: () => Modular.to.pushNamed('/home/favoritePlacesPage'),
              title: 'Lugares Favoritos',
              subTitle: 'Adicione lugares que mais gosta',
              leading: Icons.place_outlined,
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
