import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager.getInstance();

  // construtor nomeado
  DatabaseManager.getInstance();

  factory DatabaseManager() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'carros.db');
//    await deleteDatabase(path);
    print("db $path");
    var db = await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE carro(id INTEGER PRIMARY KEY, tipo TEXT, nome TEXT,'
        ' descricao TEXT, urlFoto TEXT, urlVideo TEXT, latitude TEXT,'
        ' longitude TEXT)');
  }

  Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion $newVersion");
    if (oldVersion == 1 && newVersion == 2) {
      await db.execute("alter table carro add column NOVA TEXT");
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
