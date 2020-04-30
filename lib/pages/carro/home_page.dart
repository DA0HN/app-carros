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
    _initTabs();
  }

  _initTabs() async {
    int indexTab = await Prefs.getInt("tab_index");
    _tabController = TabController(length: 3, vsync: this);

    setState(() {
      _tabController.index = indexTab;
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
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "Clássicos"),
                  Tab(text: "Esportivos"),
                  Tab(text: "Luxo"),
                ],
              ),
      ),
      body: _tabController == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
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
