import 'package:example/pages/detalhes/favorito/favorito.dart';
import 'package:example/utils/database/generic_dao.dart';

class FavoritoDao extends GenericDao<Favorito> {
  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";

}