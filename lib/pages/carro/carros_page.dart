import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/detalhes/detalhes_carro_page.dart';
import 'package:example/utils/nav.dart';
import 'package:flutter/material.dart';

class CarrosShowList extends StatelessWidget {
  List<Carro> _carros;

  CarrosShowList(this._carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _carros != null ? _carros.length : 0,
        itemBuilder: (context, index) {
          Carro carro = _carros[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(
                        value: progress.progress,
                      ),
                      imageUrl: carro.urlFoto,
                      width: 250,
                    ),
                  ),
                  Text(
                    carro.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    carro.descricao,
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarTheme.of(context),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text("DETALHES"),
                          onPressed: () => _onClickDetalhes(context, carro),
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

  _onClickDetalhes(BuildContext context, Carro carro) {
    push(context, CarroPage(carro));
  }
}
