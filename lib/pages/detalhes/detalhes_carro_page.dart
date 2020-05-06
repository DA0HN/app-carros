import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/detalhes/detalhes_bloc.dart';
import 'package:example/pages/detalhes/favorito/favorito_service.dart';
import 'package:example/widget/app_text.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro _carro;

  CarroPage(this._carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  Color color = Colors.grey;

  Carro get carro => widget._carro;

  final _detalhesBloc = DetalhesBloc();

  @override
  void initState() {
    super.initState();
    _detalhesBloc.fetch();
    FavoritoService.isFavorito(carro).then(_changeStateFavorito);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopupMenu(value),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: "Editar", child: Text("Editar")),
                PopupMenuItem(value: "Deletar", child: Text("Deletar")),
                PopupMenuItem(value: "Share", child: Text("Share"))
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(carro.urlFoto),
          _head(),
          Divider(color: Colors.blueGrey,),
          _content()
        ],
      ),
    );
  }

  _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(carro.descricao, fontSize: 16, bold: true),
        SizedBox(height: 20,),
        StreamBuilder(
          stream: _detalhesBloc.stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return text(snapshot.data);
          },
        ),
        SizedBox(height: 20, ),
      ],
    );
  }

  _head() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                text(carro.nome, fontSize: 20, bold: true),
                text(carro.tipo, fontSize: 16),
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite, color: color, size: 40),
                  onPressed: _onClickFavorito,
                ),
                IconButton(
                  icon: Icon(Icons.share, size: 40),
                  onPressed: _onClickShare,
                ),
              ],
            )
          ],
        );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  void _onClickFavorito() async {
    bool favorito = await FavoritoService.favoritar(carro);
    _changeStateFavorito(favorito);
  }

  void _changeStateFavorito(bool favorito) {
    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  void _onClickShare() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case 'Editar':
        break;
      case 'Deletar':
        break;
      case 'Share':
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _detalhesBloc.dispose();
  }
}
