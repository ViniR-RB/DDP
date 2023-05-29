import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/models/user.dart';
import 'package:maps/app/core/services/secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/models/user_repository.dart';

class AuthController {
  final UserRepository repository = UserRepository();
  final SecureStorage storage;
  AuthController(this.storage);

  Future<void> signUp(String name, String email, String password) async {
    final User user = User(
        id: const Uuid().v4().toString(),
        name: name,
        email: email,
        password: password);

    await repository.inserUser(user);
    storage.write('user_id', user.id);
    Modular.to.navigate('/home');
  }

  Future<void> logIn(String email, String password) async {
    final user = await repository.getUser(email, password);

    storage.write('user_id', user[0].id);
    print(user);
    Modular.to.navigate('/home');
  }
}
