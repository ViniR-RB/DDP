import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maps/app/core/models/user.dart';
import 'package:maps/app/core/services/secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../../core/components/custom_snackbar.dart';
import '../../core/database/models/user_repository.dart';

class AuthController {
  final UserRepository repository;
  final SecureStorage storage;
  AuthController(this.storage, this.repository);

  Future<void> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      final User user = User(
          id: const Uuid().v4().toString(),
          name: name,
          email: email,
          password: password);

      await repository.inserUser(user);
      storage.write('user_id', user.id);
      Modular.to.navigate('/home');
    } catch (e) {
      CustomSnackBar.showSnackBar(context, 'Email em uso');
    }
  }

  Future<void> logIn(
      String email, String password, BuildContext context) async {
    try {
      final user = await repository.getUser(email, password);

      await storage.write('user_id', user[0].id);
      Modular.to.navigate('/home');
    } catch (e) {
      CustomSnackBar.showSnackBar(context, 'Email ou Senha Incorreto');
    }
  }

  Future<void> checkeToken() async {
    final userId = await storage.read('user_id');
    if (userId == null) {
      Modular.to.navigate('/login');
    } else {
      final user = await repository.getUserFromId(userId);
      user.isEmpty
          ? Modular.to.navigate('/login')
          : Modular.to.navigate('/home');
    }
  }
}
