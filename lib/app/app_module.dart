import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/app_controller.dart';
import 'package:maps/app/core/database/db.dart';
import 'package:maps/app/core/database/models/contact_repository.dart';
import 'package:maps/app/core/database/models/fav_place_repository.dart';
import 'package:maps/app/core/database/models/user_repository.dart';
import 'package:maps/app/core/services/geocoding.dart';

import 'core/services/secure_storage.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => DatabaseImpl()),
        Bind.lazySingleton((i) => UserRepository(i.get())),
        Bind.lazySingleton((i) => ContactRepository(i.get())),
        Bind.lazySingleton((i) => FavoritePlaceRepository(i.get())),
        Bind.lazySingleton((i) => SecureStorage()),
        Bind.lazySingleton((i) => GeoCodingService()),
        Bind.factory((i) => AppController(i.get(), i.get()))
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
