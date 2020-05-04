import 'package:example/utils/database/db_manager.dart';
import 'package:example/utils/entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class GenericDao<T extends Entity> {
  // metodos abstratos
  String get tableName;
  T fromMap(Map<String, dynamic> map);

  // Instancia do banco de dados
  Future<Database> get db => DatabaseManager.getInstance().db;

  Future<int> save(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert("carro", entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('>> id: $id');
    return id;
  }

  Future<List<T>> findAll() async {
    final dbClient = await db;
    final entities = await dbClient.rawQuery('select * from $tableName');
    return processJson(entities);
  }

  Future<T> findById(int id) async {
    final dbClient = await db;
    final entities =
        await dbClient.rawQuery('select * from $tableName where id=?', [id]);
    if (entities.length > 0) return fromMap(entities.first);
    return null;
  }

  Future<bool> exists(int id) async {
    T futureEntity = await findById(id);
    return futureEntity != null;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName where id=?', [id]);
  }

  Future<int> deleteAll() async {
    final dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName');
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $tableName');
    return Sqflite.firstIntValue(list);
  }

  processJson(List entities) {
    return entities.map<T>((json) => fromMap(json)).toList();
  }
}
