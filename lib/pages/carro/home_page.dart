import 'package:example/pages/carro/api_carros.dart';
import 'package:example/pages/carro/carro.dart';
import 'package:example/pages/carro/carros_listview.dart';
import 'package:example/widget/app_drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Carros"),
      ),
      body: CarrosListView(),
      drawer: DrawerList(),
    );
  }
}
