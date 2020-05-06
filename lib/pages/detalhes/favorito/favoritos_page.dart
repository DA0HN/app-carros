import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/carros_page.dart';
import 'package:example/pages/detalhes/favorito/favoritos_bloc.dart';
import 'package:example/widget/app_text_error.dart';
import 'package:flutter/material.dart';

class FavoritosListView extends StatefulWidget {
  @override
  _FavoritosListViewState createState() => _FavoritosListViewState();
}

class _FavoritosListViewState extends State<FavoritosListView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _bloc = FavoritosBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return TextError("Não foi possível buscar os carros");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosShowList(carros),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  Future<List<Carro>> _onRefresh() {
    return _bloc.fetch();
  }
}
