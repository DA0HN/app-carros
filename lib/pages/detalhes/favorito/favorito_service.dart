import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/detalhes/favorito/favorito.dart';
import 'package:example/utils/dao/carro_dao.dart';
import 'package:example/utils/dao/favorito_dao.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro carro) async {
    final dao = FavoritoDao();
    bool exists = await dao.exists(carro.id);
    if (exists) {
      // remove dos favoritos
      dao.delete(carro.id);
      return false;
    } else {
      dao.save(
        Favorito(
          id: carro.id,
          nome: carro.nome,
        )
      );
      return true;
    }
  }

  static Future<bool> isFavorito(Carro carro) async {
    return await FavoritoDao().exists(carro.id);
  }

  static Future<List<Carro>> getCarros() async {
    return await CarroDao().query(
        'select * from carro c, favorito f where c.id = f.id'
    );
  }
}
