import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/carros_api.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:example/utils/bloc.dart';
import 'package:example/utils/connectivity.dart';
import 'package:example/utils/dao/carro_dao.dart';

class CarrosBloc extends Bloc<List<Carro>> {
  Future<List<Carro>> fetch(TipoCarro tipoCarro) async {
    bool networkOn = await isNetworkOn();
    List<Carro> carros;
    try {
      if (networkOn) {
        carros = await CarrosApi.getCarros(tipoCarro);
        _saveOnDB(carros);
      } else {
        carros = await CarroDao().findAllByTipo(tipoCarro);
      }
      add(carros);
    } catch (e) {
      addError(e);
    }
    return carros;
  }
  _saveOnDB(List<Carro> carros) {
    if(carros.isNotEmpty){
      final dao = new CarroDao();
      carros.forEach(dao.save);
    }
  }
}
