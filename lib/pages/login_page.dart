import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _loginCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Carros",
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          _textField("login", "Digite seu login", controller: _loginCtrl),
          SizedBox(
            height: 10,
          ),
          _textField("Senha", "Digite sua senha",
              controller: _passwordCtrl, password: true),
          SizedBox(
            height: 20,
          ),
          _button("Login", _onClickLogin),
        ],
      ),
    );
  }

  _onClickLogin() {
    String login = _loginCtrl.text;
    String password = _passwordCtrl.text;

    print("Login: $login | password: $password");
  }

  _button(String text, Function onPressed) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  TextFormField _textField(String label, String hint,
      {TextEditingController controller, bool password = false}) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      style: TextStyle(
        fontSize: 25,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 25,
          color: Colors.grey,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
