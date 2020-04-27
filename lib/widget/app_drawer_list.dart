import 'package:example/pages/login/usuario.dart';
import 'package:example/pages/login/login_page.dart';
import 'package:example/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {

  Usuario user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Gabriel Honda"),
            accountEmail: Text("gabrielhondacba@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/d08a51d4-51bd-4ef4-af5f-d9b6809aafe6/d7sxcwa-7982c5bd-93a7-4074-b376-b11bd2a1edfb.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2QwOGE1MWQ0LTUxYmQtNGVmNC1hZjVmLWQ5YjY4MDlhYWZlNlwvZDdzeGN3YS03OTgyYzViZC05M2E3LTQwNzQtYjM3Ni1iMTFiZDJhMWVkZmIucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.8aTYa5KShAnBwtZUUs1wvSHZKvvDjxenCoVOeM8JZj8"),
            ),
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

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}