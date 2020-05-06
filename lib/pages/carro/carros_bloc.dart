import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/carros_api.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:example/utils/bloc.dart';
import 'package:example/utils/dao/carro_dao.dart';

class CarrosBloc extends Bloc<List<Carro>> {
  Future<List<Carro>> fetch(TipoCarro tipoCarro) async {
    bool networkOn = false;
    List<Carro> carros;
    try {
      if (networkOn) {
        carros = await CarrosApi.getCarros(tipoCarro);
      } else {
        carros = await CarroDao().findAllByTipo(tipoCarro);
      }
      add(carros);
    } catch (e) {
      addError(e);
    }
    return carros;
  }
}
