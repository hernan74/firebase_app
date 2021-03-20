import 'dart:convert';

import 'package:fire_base_app/model/usuario_model.dart';
import 'package:fire_base_app/preferencia_usuario/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  final String _urlFireBase = 'fir-app-96edf-default-rtdb.firebaseio.com';

  final prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> buscarTodos() async {
    final url = Uri.https(_urlFireBase, '/usuarios.json', {
      'auth': prefs.token,
    });

    try {
      final resp = await http.get(url);

      Map<String, dynamic> decodeData = json.decode(resp.body);

      if (resp.statusCode == 200) {
        List<UsuarioModel> lista = [];
        if (decodeData == null) return {'ok': true, 'valor': lista};

        decodeData.forEach((id, usu) {
          final usuTemp = UsuarioModel.fromJson(usu);
          usuTemp.id = id;
          lista.add(usuTemp);
        });
        return {'ok': true, 'valor': lista};
      } else {
        return {'ok': false, 'mensaje': decodeData['error']['message']};
      }
    } catch (e) {
      return {'ok': false, 'mensaje': e.toString()};
    }
  }

  Future<Map<String, dynamic>> nuevo(UsuarioModel model) async {
    final url = Uri.https(_urlFireBase, '/usuarios.json', {
      'auth': prefs.token,
    });
    try {
      final resp = await http.post(url, body: usuarioModelToJson(model));

      final dynamic decodeData = json.decode(resp.body);

      return {'ok': true, 'valor': decodeData['name']};
    } catch (e) {
      return {'ok': false, 'mensaje': e.toString()};
    }
  }

  Future<Map<String, dynamic>> modificar(UsuarioModel model) async {
    final url = Uri.https(_urlFireBase, '/usuarios/${model.id}.json', {
      'auth': prefs.token,
    });
    try {
      final resp = await http.put(url, body: usuarioModelToJson(model));


      return {'ok': true, 'valor': UsuarioModel.fromJson(json.decode(resp.body))};
    } catch (e) {
      return {'ok': false, 'mensaje': e.toString()};
    }
  }

  Future<Map<String, dynamic>> eliminar(String id) async {
    final url = Uri.https(Uri.encodeFull(_urlFireBase), '/usuarios/$id.json', {
      'auth': prefs.token,
    });
    try {
      final resp = await http.delete(url);

      if (resp.statusCode == 200)
        return {'ok': true, 'valor': 'Se elimino el usuario'};
      else
        return {'ok': false, 'mensaje': 'No se pudo eliminar el usuario'};
    } catch (e) {
      return {'ok': false, 'mensaje': e.toString()};
    }
  }
}
