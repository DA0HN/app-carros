import 'package:example/pages/login/login_page.dart';
import 'package:example/pages/login/usuario.dart';
import 'package:example/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Usuario> futureCurrentUser = Usuario.get();
    return Drawer(
      child: ListView(
        children: <Widget>[
          FutureBuilder<Usuario>(
            future: futureCurrentUser,
            builder: (context, snapshot) {
              Usuario currentUser = snapshot.data;
              return currentUser != null
                  ? _header(currentUser)
                  : Container(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Favoritos"),
            subtitle: Text("Mais informações..."),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print("Item 1");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Ajuda"),
            subtitle: Text("Mais informações..."),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print("HELP");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _onClickLogout(context),
          ),
        ],
      ),
    );
  }

  UserAccountsDrawerHeader _header(Usuario currentUser) {
    return UserAccountsDrawerHeader(
      accountName: Text(currentUser.nome),
      accountEmail: Text(currentUser.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(currentUser.urlFoto),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    // limpa as prefs
    Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
