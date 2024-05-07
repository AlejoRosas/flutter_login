import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login/config.dart';
import 'package:login/services/shared_service.dart';

class UserService {

   static Future<Map?> getUserInfo() async {
    //Esta linea extrae el token de la sesion a traves del shared service
    final token = await SharedService.loginDetails();

    //La primera linea formatea el toke a Json
    //La segunda extra el valor del token como string
    final jsonToken = token?.toJson();
    final myToken = jsonToken?['token'];

    //Esta forma el url de la peticion desde el archivo Config
    final uri = Uri.http(Config.apiUrl, Config.usuarioAPI);

    //Se realiza la peticion junto con sus Headers
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $myToken'},
    );

    // Se valida la respuesta.
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      return json;
    } else {
      return null;
    }
  }

}