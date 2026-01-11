import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SqlRepository {
  static Database? _db;

  Future<Database> getinstance() async {
    _db ??= await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = join(dir.path, 'sql_app_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE states (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            uf TEXT NOT NULL UNIQUE
          );
        ''');

        await db.execute('''
          CREATE TABLE phone_types (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE
          );
        ''');

        await db.execute('''
          CREATE TABLE clients (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT UNIQUE,
            razao_social TEXT NOT NULL,
            state_id INTEGER NOT NULL,
            created_at TEXT NOT NULL,
            FOREIGN KEY (state_id) REFERENCES states(id)
          );
        ''');

        await db.execute('''
          CREATE TABLE phones (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            client_id INTEGER NOT NULL,
            phone_type_id INTEGER NOT NULL,
            number TEXT NOT NULL,
            FOREIGN KEY (client_id) REFERENCES clients(id),
            FOREIGN KEY (phone_type_id) REFERENCES phone_types(id)
          );
        ''');
      },
    );
  }
}
