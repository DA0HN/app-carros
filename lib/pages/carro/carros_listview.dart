import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/carro_page.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:example/utils/nav.dart';
import 'package:example/widget/app_text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'carros_model.dart';

class CarrosListView extends StatefulWidget {
  TipoCarro tipo;

  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TipoCarro get tipo => widget.tipo;

  final _model = CarrosModel();

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _fetch() {
    _model.fetch(tipo);
  }

  _body() {
    return Observer(
      builder: (_) {
        List<Carro> carros = _model.carros;
        if (_model.error != null) {
          return TextError(
            "Não foi possível buscar os carros\nClique para tentar novamente!",
            onPressed: _fetch,
          );
        }
        if (carros == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
                          onPressed: () => _onClickDetalhes(c),
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

  _onClickDetalhes(Carro carro) {
    push(context, CarroPage(carro));
  }
}
