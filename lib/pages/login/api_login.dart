import 'dart:convert';

import 'package:example/pages/api_response.dart';
import 'package:example/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class LoginAPI {
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
//    final url = "http://livrowebservices.com.br/rest/login";
    var response = await _post(username, password);
    if (response.ok) {
      return {
        "result": response.result,
        "status": response.msg,
      };
    }
    return {
      "result": null,
      "status": response.msg,
    };
  }

  static Future<ApiResponse<Usuario>> _post(
      String username, String password) async {
    try {
      final url = "http://carros-springboot.herokuapp.com/api/v2/login";

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      String jsonParams = json.encode({
        "username": username,
        "password": password,
      });

//      print(">> $jsonParams");

      var response = await http.post(
        url,
        body: jsonParams,
        headers: headers,
      );
//      print("Response status: ${response.statusCode}");
//      print("Response body: ${response.body}");

      var parsedResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(parsedResponse);
        return ApiResponse.ok(user);
      }
      return ApiResponse.error(parsedResponse["error"]);
    } catch (error, exception) {
      print("Erro no login $error > $exception");
      return ApiResponse.error("Não foi possível fazer login");
    }
  }
}
