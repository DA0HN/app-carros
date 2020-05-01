import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/carros_api.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:mobx/mobx.dart';

part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {
  @observable
  List<Carro> carros;
  @observable
  Exception error;

  @action
  fetch(TipoCarro tipo) async {
    try {
      this.error = null;
      this.carros = await ApiCarros.getCarros(tipo);
    } catch (e) {
      this.error = e;
    }
  }
}
