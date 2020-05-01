import 'dart:async';

import 'package:example/pages/carro/home_page.dart';
import 'package:example/pages/login/login_bloc.dart';
import 'package:example/pages/login/usuario.dart';
import 'package:example/utils/nav.dart';
import 'package:example/widget/app_button.dart';
import 'package:example/widget/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _loginCtrl = TextEditingController();

  final _passwordCtrl = TextEditingController();

  final _focusPassword = FocusNode();

  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
      if (user != null) {
        // Se o usuário não fizer logout o app mantém o último login ativo
        push(context, HomePage(), replace: true);
      }
    });
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
            StreamBuilder<bool>(
                initialData: false,
                stream: _bloc.stream,
                builder: (context, snapshot) {
                  return AppButton(
                    "Login",
                    onPressed: _onClickLogin,
                    showProgress: snapshot.data,
                  );
                }),
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

    Function action = await _bloc.login(context, login, password);
    action();
  }

  @override
  void dispose() {
    // libera a memória e fecha a Stream
    super.dispose();
    _bloc.dispose();
  }
}
