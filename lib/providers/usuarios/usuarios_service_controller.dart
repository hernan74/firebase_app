import 'package:fire_base_app/providers/usuarios/usuarios_service.dart';
import 'package:fire_base_app/providers/usuarios/usuarios_stream.dart';
import 'package:flutter/cupertino.dart';

class UsuarioServiceController {
  final usuarioService = new UsuariosService();
  final UsuariosStream usuariosStream;

  UsuarioServiceController({@required this.usuariosStream});

  Future<Map<String, dynamic>> buscarTodos() async {
    Map<String, dynamic> resp = await usuarioService.buscarTodos();
    if (resp['ok'] == true) {
      if (resp.containsKey('valor'))
        usuariosStream.cargarUsuarios(resp['valor']);
    }
    return resp;
  }
}
