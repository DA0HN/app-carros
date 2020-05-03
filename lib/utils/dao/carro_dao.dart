import 'package:example/pages/carro/carro.dart';
import 'package:example/utils/database/db_manager.dart';
import 'package:sqflite/sqflite.dart';

class CarroDao {
  Future<Database> get db => DatabaseManager.getInstance().db;

  Future<int> save(Carro carro) async {
    var dbClient = await db;
    var id = await dbClient.insert("carro", carro.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('>> id: $id');
    return id;
  }

  _processJson(List carros) {
    return carros.map<Carro>((json) => Carro.fromJson(json)).toList();
  }

  Future<List<Carro>> findAll() async {
    final dbClient = await db;
    final carros = await dbClient.rawQuery('select * from carro');
    return _processJson(carros);
  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;
    final carros =
        await dbClient.rawQuery('select * from carro where tipo=?', [tipo]);
    return _processJson(carros);
  }

  Future<Carro> findById(int id) async {
    final dbClient = await db;
    final carros =
        await dbClient.rawQuery('select * from carro where id=?', [id]);
    if (carros.length > 0) return new Carro.fromJson(carros.first);
    return null;
  }

  Future<bool> exists(Carro carro) async {
    Carro carroFuture =  await findById(carro.id);
    return carroFuture != null;
  }

  Future<int> delete(int id ) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from carro where id=?', [id]);
  }

  Future<int> deleteAll() async {
    final dbClient = await db;
    return await dbClient.rawDelete('delete from carro');
  }
}
