import 'dart:convert';

import 'package:fire_base_app/model/usuario_model.dart';
import 'package:fire_base_app/preferencia_usuario/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  final String _urlFireBase = 'fir-app-96edf-default-rtdb.firebaseio.com';

  final prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> buscarTodos() async {
    final url = Uri.https(_urlFireBase, '/productos.json', {
      'auth': prefs.token,
    });

    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    try {
      if (resp.statusCode == 200) {
        List<UsuarioModel> lista = [];

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
      return {'ok': false, 'mensaje': decodeData['error']['message']};
    }
  }
}
