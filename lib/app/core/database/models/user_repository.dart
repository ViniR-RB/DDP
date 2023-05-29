import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/user.dart';

class UserRepository {
  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'dpm.db';
    final path = join(dbpath, dbname);
    _database = await openDatabase(path, version: 1, onCreate: createDB);
    return _database!;
  }

  FutureOr<void> createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS users (id UUID PRIMARY KEY,name VARCHAR(255),email VARCHAR(255),password VARCHAR(255));');
  }

  Future<void> inserUser(User user) async {
    final db = await database;

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> getUser(String email, String password) async {
    final db = await database;

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
}
