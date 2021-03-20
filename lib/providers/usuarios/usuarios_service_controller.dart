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
    provider.estadoCargaSink(false);
    Map<String, dynamic> resp = await usuarioService.buscarTodos();
    if (resp['ok'] == true) {
      if (resp.containsKey('valor')) provider.cargarUsuarios(resp['valor']);
    } else {
      mostrarSnackBar(context: context, msj: resp['mensaje']);
    }
    provider.estadoCargaSink(true);
  }

  Future<bool> nuevo(UsuarioModel usuario) async {
    if (provider.estadoCarga == false) return false;
    provider.estadoCargaSink(false);
    Map<String, dynamic> resp = await usuarioService.nuevo(usuario);
    if (resp['ok'] == true) {
      if (resp.containsKey('valor')) {
        buscarTodos();
        return true;
      }
    } else {
      mostrarSnackBar(context: context, msj: resp['mensaje']);
    }

    provider.estadoCargaSink(true);
    return false;
  }

  Future<bool> modificar(UsuarioModel usuario) async {
    if (provider.estadoCarga == false) return false;
    provider.estadoCargaSink(false);
    Map<String, dynamic> resp = await usuarioService.modificar(usuario);
    if (resp['ok'] == true) {
      if (resp.containsKey('valor')) {
        buscarTodos();

        provider.estadoCargaSink(true);
        return true;
      }
    } else {
      mostrarSnackBar(context: context, msj: resp['mensaje'], isError: true);
    }

    provider.estadoCargaSink(true);
    return false;
  }

  Future<bool> eliminar(String id) async {
    provider.estadoCargaSink(false);
    Map<String, dynamic> resp = await usuarioService.eliminar(id);
    if (resp['ok'] == true) {
      return true;
    } else {
      mostrarSnackBar(context: context, msj: resp['mensaje'], isError: true);
    }

    provider.estadoCargaSink(true);
    return false;
  }
}
