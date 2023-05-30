import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/home/home_controller.dart';
import 'package:maps/app/modules/home/pages/contacts_page.dart';

import 'home_page.dart';
import 'pages/profile_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [Bind((i) => HomeController(i.get(), i.get()))];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const HomePage(),
        ),
        ChildRoute(
          '/profile',
          child: (context, args) => const ProfilePage(),
        ),
        ChildRoute(
          '/contacts',
          child: (context, args) => ContactsPage(),
        ),
      ];
}
