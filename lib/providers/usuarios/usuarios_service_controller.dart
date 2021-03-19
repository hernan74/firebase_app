import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/model/usuario_model.dart';
import 'package:fire_base_app/providers/usuarios/usuarios_service.dart';
import 'package:fire_base_app/providers/usuarios/usuarios_stream.dart';
import 'package:fire_base_app/widget/crear_snack.dart';
import 'package:flutter/cupertino.dart';

class UsuarioServiceController {
  final usuarioService = new UsuariosService();

  UsuariosStream provider;
  BuildContext context;

  UsuarioServiceController(BuildContext context) {
    this.context = context;
    provider = BlocProvider.usuariosBloc(context);
  }

  void buscarTodos() async {
    Map<String, dynamic> resp = await usuarioService.buscarTodos();
    if (resp['ok'] == true) {
      if (resp.containsKey('valor')) provider.cargarUsuarios(resp['valor']);
    } else {
      mostrarSnackBar(context: context, msj: resp['valor']);
    }
  }

  Future<bool> nuevo(UsuarioModel usuario) async {
    Map<String, dynamic> resp = await usuarioService.nuevo(usuario);
    if (resp['ok'] == true) {
      if (resp.containsKey('valor')) return true;
    } else {
      mostrarSnackBar(context: context, msj: resp['mensaje']);
    }
    return false;
  }

  Future<bool> modificar(UsuarioModel usuario) async {
    Map<String, dynamic> resp = await usuarioService.modificar(usuario);
    if (resp['ok'] == true) {
      if (resp.containsKey('valor')) return true;
    } else {
      mostrarSnackBar(context: context, msj: resp['mensaje']);
    }
    return false;
  }

  Future<bool> eliminar(String id) async {
    Map<String, dynamic> resp = await usuarioService.eliminar(id);
    if (resp['ok'] == true) {
      if (resp.containsKey('valor')) return true;
    } else {
      mostrarSnackBar(context: context, msj: resp['mensaje']);
    }
    return false;
  }
}
