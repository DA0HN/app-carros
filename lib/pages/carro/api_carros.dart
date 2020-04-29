import 'dart:convert' as convert;

import 'package:example/pages/carro/carro.dart';
import 'package:http/http.dart' as http;

class ApiCarros {
  static Future<List<Carro>> getCarros() async {
    var url = "https://carros-springboot.herokuapp.com/api/v1/carros";
    print(">> GET $url");
    var response = await http.get(url);

    String json = response.body;
    List responseList = convert.json.decode(json);

    final carros = responseList.map<Carro>((data) => Carro.fromJson(data)).toList();

    return carros;
  }
}
