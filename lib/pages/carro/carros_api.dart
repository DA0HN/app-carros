import 'dart:convert' as convert;

import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:example/pages/login/usuario.dart';
import 'package:example/utils/dao/carro_dao.dart';
import 'package:http/http.dart' as http;

class CarrosApi {
  static Future<List<Carro>> getCarros(TipoCarro tipo) async {
    final String token = await getToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var url =
        "http://carros-springboot.herokuapp.com/api/v2/carros/tipo/${tipo.tipo}";
    print(">> GET $url");
    var response = await http.get(url, headers: headers);

    String json = response.body;
//    print(">> Status code: ${response.statusCode}");
//    print(json);

    try {
      List responseList = convert.json.decode(json);
      final carros =
          responseList.map<Carro>((data) => Carro.fromMap(data)).toList();
      _saveOnDB(carros);
      return carros;
    } catch (error, exception) {
      print(">> Error: $error | $exception");
      throw exception;
    }
  }

  static _saveOnDB(List<Carro> carros) {
    final dao = new CarroDao();
    carros.forEach(dao.save);
  }

  static Future<String> getToken() async {
    Usuario user = await Usuario.get();
    return user.token;
  }
}
