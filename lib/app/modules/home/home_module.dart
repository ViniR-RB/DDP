import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/home/home_controller.dart';
import 'package:maps/app/modules/home/home_repository.dart';
import 'package:maps/app/modules/home/pages/contacts_page.dart';
import 'package:maps/app/modules/home/pages/detail_contact.dart';

import '../../app_controller.dart';
import '../../core/database/models/contact_repository.dart';
import '../../core/services/geocoding.dart';
import '../../core/services/secure_storage.dart';
import 'home_page.dart';
import 'maps/maps_module.dart';
import 'pages/profile_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => HomeController(
              i.get<AppController>(),
              i.get<HomeRepository>(),
            )),
        Bind.singleton((i) => HomeRepository(i.get<GeoCodingService>(),
            i.get<ContactRepository>(), i.get<SecureStorage>())),
      ];

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
          child: (context, args) => const ContactsPage(),
        ),
        ChildRoute(
          '/detailContactPage',
          child: (context, args) => DetailContactPage(args: args.data),
        ),
        ModuleRoute('/maps', module: MapsModule())
      ];
}
