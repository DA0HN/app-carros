class Usuario {
  String _login;
  String _nome;
  String _email;
  String _token;

  List<String> _roles;

  Usuario.fromJson(Map<String, dynamic> map) :
        this._login = map["login"],
        this._token = map["token"],
        this._nome = map["nome"],
        this._email = map["email"],
        this._roles = map["roles"] != null ? _getRoles(map) : null;

  @override
  String toString() {
    return 'Usuario{login: $_login, nome: $_nome, email: $_email, token: $_token, roles: $_roles}';
  }

  static _getRoles(Map<String, dynamic> map) {
    return map["roles"]
        .map<String>((role) => role.toString())
        .toList();
  }
}

