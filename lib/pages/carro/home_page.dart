import 'package:example/pages/carro/carros_listview.dart';
import 'package:example/pages/carro/tipo_carro.dart';
import 'package:example/utils/prefs.dart';
import 'package:example/widget/app_drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future<int> futureValue = Prefs.getInt("tab_index");

    futureValue.then((int tabIndex) {
      _tabController.index = tabIndex;
    });

    _tabController.addListener(() {
      Prefs.setInt("tab_index", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Clássicos"),
            Tab(text: "Esportivos"),
            Tab(text: "Luxo"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosListView(TipoCarro.classicos()),
          CarrosListView(TipoCarro.esportivos()),
          CarrosListView(TipoCarro.luxo()),
        ],
      ),
      drawer: DrawerList(),
    );
  }
}
