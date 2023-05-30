import 'package:flutter/foundation.dart';
import 'package:maps/app/core/models/contact.dart';

import '../../app_controller.dart';
import '../../core/models/user.dart';
import 'home_repository.dart';

class HomeController {
  final HomeRepository repository;
  final AppController controller;

  ValueNotifier<User> user = ValueNotifier(
      User(id: 'id', name: 'name', email: 'email', password: 'password'));
  ValueNotifier<List<Contact>> contact = ValueNotifier([]);

  HomeController(this.controller, this.repository);

  Future<void> whoIsMyUser() async {
    user.value = await controller.howMyUser();
  }

  Future<void> createContact(String nome, String phone, String address) async {
    await repository.createContact(nome, phone, address);
  }

  Future<void> fetchContacts() async {
    contact.value = await repository.fetchContacts();
  }
}
