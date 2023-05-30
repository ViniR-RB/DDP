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
    _database = await openDatabase(path,
        onConfigure: _onConfigure, version: 1, onCreate: createDB);
    return _database!;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS users (id UUID PRIMARY KEY,name VARCHAR(255),email VARCHAR(255) UNIQUE,password VARCHAR(255))');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS contacts (id UUID PRIMARY KEY,name VARCHAR(255), user_id UUID,phone VARCHAR(11), latitude DECIMAL(9,6),longitude DECIMAL(9,6),FOREIGN KEY (user_id) REFERENCES users (id))');
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

  Future<List<User>> getUserFromId(String id) async {
    final db = await database;

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
