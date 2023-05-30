import 'package:maps/app/core/services/secure_storage.dart';

import 'core/database/models/user_repository.dart';
import 'core/models/user.dart';

class AppController {
  final UserRepository repository;
  final SecureStorage secure;
  AppController(this.repository, this.secure);

  Future<User> howMyUser() async {
    final userId = await secure.read("user_id");
    print(userId);
    final user = await repository.getUserFromId(userId!);
    return user[0];
  }
}
