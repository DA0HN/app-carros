import 'dart:async';

import 'package:example/pages/api_response.dart';
import 'package:example/pages/carro/home_page.dart';
import 'package:example/pages/login/login_api.dart';
import 'package:example/pages/login/usuario.dart';
import 'package:example/utils/alert.dart';
import 'package:example/utils/bloc.dart';
import 'package:example/utils/nav.dart';
import 'package:flutter/cupertino.dart';

class LoginBloc extends Bloc<bool> {
  Future<Function> login(BuildContext context, String username, String password) async {
    // redesenha a tela com a animação de loading
    add(true);
    var response = await ApiLogin.login(username, password);
    return _responseAction(response, context);
  }

  _responseAction(ApiResponse<Usuario> response, BuildContext context) {
    // redesenha a tela para retirar a animação de loading
    add(false);
    if (response.ok) {
      return () => push(context, HomePage(), replace: true);
    } else {
      return alert(context, response.msg);
    }
  }
}
