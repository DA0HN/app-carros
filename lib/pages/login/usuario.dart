import 'dart:convert' as convert;

import 'package:example/utils/prefs.dart';

class Usuario {
  String _login;
  String _nome;
  String _email;
  String _urlFoto;
  String _token;

  List<String> _roles;

  Usuario.fromJson(Map<String, dynamic> map)
      : this._login = map["login"],
        this._token = map["token"],
        this._urlFoto = map["urlFoto"],
        this._nome = map["nome"],
        this._email = map["email"],
//        this._roles = map["roles"].cast<String>();
        this._roles = map["roles"] != null ? _getRoles(map) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map();
    data['login'] = this._login;
    data['token'] = this._token;
    data['nome'] = this._nome;
    data['urlFoto'] = this._urlFoto;
    data['email'] = this._email;
    data['roles'] = this._roles;
    return data;
  }

  String get login => _login;

  @override
  String toString() {
    return 'Usuario{login: $_login, nome: $_nome, email: $_email, token: $_token, roles: $_roles}';
  }

  static _getRoles(Map<String, dynamic> map) {
    return map["roles"].map<String>((role) => role.toString()).toList();
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("user.prefs", json);
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  static Future<Usuario> get() async {
    String json = await Prefs.getString("user.prefs");

    if (json.isEmpty) return null;

    Map map = convert.json.decode(json);
    Usuario user = Usuario.fromJson(map);
    return user;
  }

  String get nome => _nome;

  String get email => _email;

  String get urlFoto => _urlFoto;

  String get token => _token;

  List<String> get roles => _roles;
}
