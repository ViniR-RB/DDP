import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/card_category.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
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
