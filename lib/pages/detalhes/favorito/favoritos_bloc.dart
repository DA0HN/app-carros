import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/detalhes/favorito/favorito_service.dart';
import 'package:example/utils/bloc.dart';

class FavoritosBloc extends Bloc<List<Carro>> {
  Future<List<Carro>> fetch() async {
    List<Carro> carros;
    try {
      carros = await FavoritoService.getCarros();
      add(carros);
    } catch (e) {
      addError(e);
    }
    return carros;
  }
}
