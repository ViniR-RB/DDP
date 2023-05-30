import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/contact.dart';

class ContactRepository {
  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'dpm.db';
    final path = join(dbpath, dbname);
    // Conectando
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    return _database!;
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS contacts (id UUID PRIMARY KEY,name VARCHAR(255), user_id UUID,phone VARCHAR(11), latitude DECIMAL(9,6),longitude DECIMAL(9,6),FOREIGN KEY (user_id) REFERENCES users (id))');
  }

  Future<void> inserContact(Contact contact) async {
    final db = await database;

    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteContact(String id) async {
    final db = await database;
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Contact>> getAllContacts(String id) async {
    final db = await database;

    List<Map<String, dynamic>> items =
        await db.query('contacts', where: 'id = ?', whereArgs: [id]);

    return List.generate(
      items.length,
      (i) => Contact(
          id: items[i]['id'],
          latitude: items[i]['latitude'],
          longitude: items[i]['longitude'],
          name: items[i]['name'],
          userId: items[i]['user_id']),
    );
  }

  Future<List<Contact>> getContactsFromUser(dynamic userId) async {
    final db = await database;

    List<Map<String, dynamic>> items =
        await db.query('contacts', where: 'user_id = ?', whereArgs: [userId]);

    return List.generate(
      items.length,
      (i) => Contact(
          id: items[i]['id'],
          latitude: items[i]['latitude'],
          longitude: items[i]['longitude'],
          name: items[i]['name'],
          userId: items[i]['user_id']),
    );
  }
}
