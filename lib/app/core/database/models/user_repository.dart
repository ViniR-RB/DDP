import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../models/user.dart';
import '../db.dart';

class UserRepository {
  final DatabaseImpl database;

  UserRepository(this.database);

  Future<void> inserUser(User user) async {
    final db = await database.database;

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> getUser(String email, String password) async {
    final db = await database.database;

    List<Map<String, dynamic>> items = await db.query('users',
        where: 'email = ? and password = ?', whereArgs: [email, password]);

    return List.generate(
      items.length,
      (i) => User(
        id: items[i]['id'],
        name: items[i]['name'],
        email: items[i]['email'],
        password: items[i]['password'],
      ),
    );
  }

  Future<List<User>> getUserFromId(String id) async {
    final db = await database.database;

    List<Map<String, dynamic>> items =
        await db.query('users', where: 'id = ?', whereArgs: [id]);

    return List.generate(
      items.length,
      (i) => User(
        id: items[i]['id'],
        name: items[i]['name'],
        email: items[i]['email'],
        password: items[i]['password'],
      ),
    );
  }
}
