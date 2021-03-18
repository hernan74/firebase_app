import 'dart:async';

import 'package:fire_base_app/model/usuario_model.dart';
import 'package:rxdart/rxdart.dart';

class UsuariosStream {
  final _usuariosStreamController = new BehaviorSubject<List<UsuarioModel>>();

  Function(List<UsuarioModel>) get usuariosSink =>
      _usuariosStreamController.sink.add;

  cargarUsuarios(List<UsuarioModel> lista) {
    _usuariosStreamController.sink.add(lista);
  }

  Stream<List<UsuarioModel>> get usuariosStream =>
      _usuariosStreamController.stream;

  void disposeStreams() {
    _usuariosStreamController.close();
  }
}
