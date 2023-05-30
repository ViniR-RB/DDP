import 'package:flutter/foundation.dart';

import '../../app_controller.dart';
import '../../core/models/user.dart';
import 'home_repository.dart';

class HomeController {
  final HomeRepository repository;
  final AppController controller;

  ValueNotifier<User> user = ValueNotifier(
      User(id: 'id', name: 'name', email: 'email', password: 'password'));
  HomeController(this.controller, this.repository);

  Future<void> whoIsMyUser() async {
    user.value = await controller.howMyUser();
  }

  Future<void> createContact(String nome, String phone, String address) async {
    await repository.createContact(nome, phone, address);
  }
}
