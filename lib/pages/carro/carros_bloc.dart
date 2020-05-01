import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/carros_api.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:example/utils/bloc.dart';

class CarrosBloc extends Bloc<List<Carro>> {
  Future<List<Carro>> fetch(TipoCarro tipo) async {
    List<Carro> carros;
    try {
      carros = await CarrosApi.getCarros(tipo);
      add(carros);
    } catch (e) {
      addError(e);
    }
    return carros;
  }
}
