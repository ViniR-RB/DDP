import 'package:flutter_modular/flutter_modular.dart';

import 'maps_page.dart';

class MapsModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => const MapsPage()),
      ];
}
