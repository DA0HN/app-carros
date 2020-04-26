import 'package:example/api/login_api.dart';
import 'package:example/api/model/usuario.dart';
import 'package:example/pages/home_page.dart';
import 'package:example/utils/nav.dart';
import 'package:example/widget/app_button.dart';
import 'package:example/widget/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _loginCtrl = TextEditingController(text: "admin");

  final _passwordCtrl = TextEditingController(text: "123");

  final _focusPassword = FocusNode();

  @override
  void initState() {
    super.initState();
  }

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
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "login",
              "Digite seu login",
              controller: _loginCtrl,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              nextFocus: _focusPassword,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Senha",
              "Digite sua senha",
              controller: _passwordCtrl,
              password: true,
              validator: _validatePassword,
              keyboardType: TextInputType.number,
              focusNode: _focusPassword,
            ),
            SizedBox(
              height: 20,
            ),
            AppButton("Login", _onClickLogin),
          ],
        ),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validatePassword(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter mais de 4 caracteres";
    }
    return null;
  }

  void _onClickLogin() async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    String login = _loginCtrl.text;
    String password = _passwordCtrl.text;

    Usuario user = await LoginAPI.login(login, password);

    if( user != null ) {
      print(">>> $user");
      push(context, HomePage());
    }
    else {
      // TODO: substituir por mensagem no app
      print("Login incorreto");
    }
  }
}
