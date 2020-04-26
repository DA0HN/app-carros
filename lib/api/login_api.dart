import 'dart:convert';

import 'package:example/api/model/usuario.dart';
import 'package:http/http.dart' as http;

class LoginAPI {
  static Future<Usuario> login(String username, String password) async {
//    final url = "http://livrowebservices.com.br/rest/login";
    Map response = await _post(username, password);

    return Usuario.fromJson(response);
  }

  static Future<Map> _post(String username, String password) async {
    final url = "http://carros-springboot.herokuapp.com/api/v2/login";

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    String jsonParams = json.encode({
      "username": username,
      "password": password,
    });

    print(">> $jsonParams");

    var response = await http.post(
      url,
      body: jsonParams,
      headers: headers,
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    return json.decode(response.body);
  }
}
