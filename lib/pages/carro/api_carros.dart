import 'package:example/pages/carro/carro.dart';

class ApiCarros {
  static Future<List<Carro>> getCarros() async {
    final List<Carro> carros = List<Carro>();

    await Future.delayed(Duration(seconds: 2));

    carros.add(
      Carro(
          nome: "Ferrari FF Testarossa",
          urlFoto: "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png"),
    );
    carros.add(
      Carro(
          nome: "Porsche Panamera",
          urlFoto: "http://www.livroandroid.com.br/livro/carros/esportivos/Porsche_Panamera.png"),
    );
    carros.add(
      Carro(
          nome: "Lamborghini Aventador",
          urlFoto:
              "http://www.livroandroid.com.br/livro/carros/esportivos/Lamborghini_Aventador.png"),
    );
    return carros;
  }
}
