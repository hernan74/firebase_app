import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  final String _fireBaseToken = 'AIzaSyDfPd_FQX_GzwEF-tkFft1lYcdWgvju5JI';

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

    try {
      if (resp.statusCode == 200) {
        Map<String, dynamic> decodeResp = json.decode(resp.body);

        if (decodeResp.containsKey('idToken')) {
          return {'ok': true, 'mensaje': decodeResp['idToken']};
        } else {
          return {'ok': false, 'mensaje': decodeResp['error']['message']};
        }
      } else {
        return {'ok': false, 'mensaje': 'No se pudo conectar al servidor'};
      }
    } catch (e) {
      return {'ok': false, 'mensaje': 'No se pudo conectar al servidor'};
    }
  }

  Future<Map<String, dynamic>> registro(
      {String email, String password}) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_fireBaseToken'),
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    try {
      if (resp.statusCode == 200) {
        if (decodeResp.containsKey('idToken')) {
          return {'ok': true, 'token': decodeResp['idToken']};
        } else {
          return {'ok': false, 'mensaje': decodeResp['error']['message']};
        }
      } else {
        return {'ok': false, 'mensaje': decodeResp['error']['message']};
      }
    } catch (e) {
      return {'ok': false, 'mensaje': decodeResp['error']['message']};
    }
  }
}
