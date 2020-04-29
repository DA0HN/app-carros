import 'package:example/pages/carro/api_carros.dart';
import 'package:example/pages/carro/carro.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    Future<List<Carro>> futureData = ApiCarros.getCarros();
    return FutureBuilder(
      future: futureData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Text(
              "Não foi possível buscar os carros",
              style: TextStyle(
                fontSize: 22,
                color: Colors.red,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      c.urlFoto ??
                          "http://www.livroandroid.com.br/livro/carros/luxo/Koenigsegg_CCX.png",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome ?? "desconhecido",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    c.descricao ?? "descrição...",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarTheme.of(context),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text("DETALHES"),
                          onPressed: () {},
                        ),
                        FlatButton(
                          child: const Text("SHARE"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
