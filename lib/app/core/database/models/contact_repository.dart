import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../models/contact.dart';
import '../db.dart';

class ContactRepository {
  final DatabaseImpl _database;
  ContactRepository(this._database);

  Future<void> inserContact(Contact contact) async {
    final db = await _database.database;

    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteContact(String id) async {
    final db = await _database.database;
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Contact>> getAllContacts(String id) async {
    final db = await _database.database;

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
    final db = await _database.database;

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
