import 'dart:convert';

import 'package:fire_base_app/preferencia_usuario/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

class LoginService {

  final String _fireBaseToken = 'AIzaSyDfPd_FQX_GzwEF-tkFft1lYcdWgvju5JI';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login({String email, String password}) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_fireBaseToken'),
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('idToken')) {
      _prefs.token= decodeResp['idToken'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeResp['error']['message']};
    }
  }

}
