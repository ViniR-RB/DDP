import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../config/sql_databases.dart';

class DatabaseImpl {
  Database? _database;
  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'dpm.db';
    final path = join(dbpath, dbname);
    _database = await openDatabase(path,
        version: 1, onConfigure: _onConfigure, onCreate: _createDB);
    return _database!;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(SqlDatabase.userSql);
    await db.execute(SqlDatabase.contactSql);
  }
}
