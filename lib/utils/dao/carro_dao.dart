import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:example/utils/dao/generic_dao.dart';

class CarroDao extends GenericDao<Carro> {
  Future<List<Carro>> findAllByTipo(TipoCarro tipo) async {
    final dbClient = await db;
    final carros = await dbClient
        .rawQuery('select * from $tableName where tipo=?', [tipo.tipo]);
    return processJson(carros);
  }

  @override
  String get tableName => "carro";

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }
}
