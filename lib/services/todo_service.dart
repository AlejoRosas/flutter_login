import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login/config.dart';
import 'package:login/services/shared_service.dart';

class TodoService {
  //static const apiUrl = 'https://api.nstack.in';

  static Future<bool> deleteById(String id) async {
    //Esta linea extrae el token de la sesion a traves del shared service
    final token = await SharedService.loginDetails();

    //La primera linea formatea el toke a Json
    //La segunda extra el valor del token como string
    final jsonToken = token?.toJson();
    final myToken = jsonToken?['token'];

    //Esta forma el url de la peticion desde el archivo Config
    final uri = Uri.http(Config.apiUrl, '${Config.localidadAPI}/$id');

    final response = await http.delete(
      uri,
      headers: {'Authorization': 'Bearer $myToken'},
    );
    return response.statusCode == 200;
  }

  static Future<List?> fetchTodos() async {
    //Esta linea extrae el token de la sesion a traves del shared service
    final token = await SharedService.loginDetails();

    //La primera linea formatea el toke a Json
    //La segunda extra el valor del token como string
    final jsonToken = token?.toJson();
    final myToken = jsonToken?['token'];

    //Esta forma el url de la peticion desde el archivo Config
    final uri = Uri.http(Config.apiUrl, Config.localidadAPI);

    //Se realiza la peticion junto con sus Headers
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $myToken'},
    );

    // Se valida la respuesta.
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json;
    } else {
      return null;
    }
  }

  //En este caso no se envia el ID como parametro en la función ya que
  //En el body se esta enviando el ID, esto no es un estandar y depende de
  //la estructura que tenga el back
  static Future<bool> updateTodo(Map body) async {
    //Esta linea extrae el token de la sesion a traves del shared service
    final token = await SharedService.loginDetails();

    //La primera linea formatea el toke a Json
    //La segunda extra el valor del token como string
    final jsonToken = token?.toJson();
    final myToken = jsonToken?['token'];

    //Esta forma el url de la peticion desde el archivo Config
    final uri = Uri.http(Config.apiUrl, Config.localidadAPI);

    //Se realiza la peticion junto con sus Headers
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {
        'Authorization': 'Bearer $myToken',
        'Content-Type': 'application/json',
      },
    );

    return response.statusCode == 200;
  }

  static Future<bool> addTodo(Map body) async {
    //Esta linea extrae el token de la sesion a traves del shared service
    final token = await SharedService.loginDetails();

    //La primera linea formatea el toke a Json
    //La segunda extra el valor del token como string
    final jsonToken = token?.toJson();
    final myToken = jsonToken?['token'];

    //Esta forma el url de la peticion desde el archivo Config
    final uri = Uri.http(Config.apiUrl, Config.localidadAPI);

    //Se realiza la peticion junto con sus Headers
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Authorization': 'Bearer $myToken',
        'Content-Type': 'application/json',
      },
    );

    // Se valida la respuesta.
    return response.statusCode == 200;
  }
}
