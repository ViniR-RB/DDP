import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/database/models/user_repository.dart';

import 'core/services/secure_storage.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => UserRepository()),
        Bind((i) => SecureStorage()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
