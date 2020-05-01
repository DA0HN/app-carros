import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/carros_api.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:example/utils/bloc.dart';

class CarrosBloc extends Bloc<List<Carro>> {
  void fetch(TipoCarro tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      add(carros);
    } catch (e) {
      addError(e);
    }
  }
}
