import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/modules/auth/auth_controller.dart';
import 'package:maps/app/modules/auth/login_page.dart';
import 'package:maps/app/modules/auth/signup_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [Bind((i) => AuthController(i.get()))];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => const LoginPage()),
        ChildRoute('/signup', child: (context, args) => const SignUpPage()),
      ];
}
