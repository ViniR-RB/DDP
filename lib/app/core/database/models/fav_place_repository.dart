import 'dart:async';

import 'package:maps/app/core/models/fav_place.dart';
import 'package:sqflite/sqflite.dart';

import '../db.dart';

class FavoritePlaceRepository {
  final DatabaseImpl _database;
  FavoritePlaceRepository(this._database);

  Future<void> inserPlace(FavoritePlace place) async {
    final db = await _database.database;

    await db.insert(
      'places',
      place.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// retornar um lugar favorito
  Future<FavoritePlace?> detailPlace(String id) async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'places',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return FavoritePlace.fromMap(maps.first);
    }

    return null;
  }

//realizar update em um lugar favorito
  Future<void> updatePlace(FavoritePlace? updplace) async {
    final db = await _database.database;

    if (updplace != null) {
      await db.update(
        'places',
        updplace.toMap(),
        where: 'id = ?',
        whereArgs: [updplace.id],
      );
    }
  }

  Future<void> deletePlace(String id) async {
    final db = await _database.database;
    await db.delete('places', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<FavoritePlace>> getAllplaces(String id) async {
    final db = await _database.database;

    List<Map<String, dynamic>> items =
        await db.query('places', where: 'id = ?', whereArgs: [id]);

    return List.generate(
      items.length,
      (i) => FavoritePlace(
          id: items[i]['id'],
          name: items[i]['name'],
          phone: items[i]['phone'],
          address: items[i]['address'],
          socialmidia: items[i]['socialmidia'],
          description: items[i]['description'],
          latitude: items[i]['latitude'],
          longitude: items[i]['longitude'],
          userId: items[i]['user_id']),
    );
  }

  Future<List<FavoritePlace>> getplacesFromUser(dynamic userId) async {
    final db = await _database.database;

    List<Map<String, dynamic>> items =
        await db.query('places', where: 'user_id = ?', whereArgs: [userId]);

    return List.generate(
      items.length,
      (i) => FavoritePlace(
          id: items[i]['id'],
          name: items[i]['name'],
          phone: items[i]['phone'],
          address: items[i]['address'],
          socialmidia: items[i]['socialmidia'],
          description: items[i]['description'],
          latitude: items[i]['latitude'],
          longitude: items[i]['longitude'],
          userId: items[i]['user_id']),
    );
  }
}
