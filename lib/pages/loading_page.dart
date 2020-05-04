import 'package:example/pages/home_page.dart';
import 'package:example/pages/login/login_page.dart';
import 'package:example/pages/login/usuario.dart';
import 'package:example/utils/database/db_manager.dart';
import 'package:example/utils/nav.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*
* @project carros
* @author Gabriel on 03/05/2020
*/
class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    Future initializeDatabase = DatabaseManager.getInstance().db;
    Future minTimeLoading = Future.delayed(Duration(seconds: 3));
    Future loadUser = Usuario.get();

    Future.wait([initializeDatabase, minTimeLoading, loadUser])
        .then((List values) {
      Usuario currentUser = values[2];
      // Checa se o usuario já estava logado anteriormente
      if (currentUser != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[300],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
