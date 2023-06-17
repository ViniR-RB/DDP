import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/home/maps/maps_controller.dart';
import 'package:maps/app/modules/home/maps/maps_repository.dart';

import 'maps_page.dart';

class MapsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => MapsController(i.get())),
        Bind((i) => MapsRepository(i.get(), i.get(), i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => const MapsPage()),
      ];
}
