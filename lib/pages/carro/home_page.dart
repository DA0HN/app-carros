import 'package:example/pages/carro/carros_listview.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:example/widget/app_drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Carros"),
          bottom: TabBar(tabs: [
            Tab(
              text: "Clássicos",
            ),
            Tab(
              text: "Esportivos",
            ),
            Tab(
              text: "Luxo",
            ),
          ]),
        ),
        body: TabBarView(children: [
          CarrosListView(TipoCarro.classicos()),
          CarrosListView(TipoCarro.esportivos()),
          CarrosListView(TipoCarro.luxo()),
        ]),
        drawer: DrawerList(),
      ),
    );
  }
}
