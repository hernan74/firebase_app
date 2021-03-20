import 'dart:async';

import 'package:fire_base_app/model/usuario_model.dart';
import 'package:fire_base_app/validators/usaurio_validator.dart';
import 'package:rxdart/rxdart.dart';

class UsuariosStream with UsuarioValidator {
  final _estadoCarga = new BehaviorSubject<bool>();

  final _usuariosStreamController = new BehaviorSubject<List<UsuarioModel>>();
  final _usuarioStreamController = new BehaviorSubject<UsuarioModel>();

  final _idUsuarioController = new BehaviorSubject<String>();
  final _nombreUsuarioController = new BehaviorSubject<String>();
  final _apellidoUsuarioController = new BehaviorSubject<String>();
  final _telefonoUsuarioController = new BehaviorSubject<String>();
  final _ubicacionUsuarioController = new BehaviorSubject<String>();

  Function(List<UsuarioModel>) get usuariosSink =>
      _usuariosStreamController.sink.add;

  cargarUsuarios(List<UsuarioModel> lista) {
    _usuariosStreamController.sink.add(lista);
  }

  Stream<List<UsuarioModel>> get usuariosStream =>
      _usuariosStreamController.stream;

  set usuarioUsuario(UsuarioModel model) {
    _usuarioStreamController.sink.add(model);
    _idUsuarioController.sink.add(model.id ?? '');
    _nombreUsuarioController.sink.add(model.nombre ?? '');
    _apellidoUsuarioController.sink.add(model.apellido ?? '');
    _telefonoUsuarioController.sink.add(model.telefono?.toString() ?? '');
    _ubicacionUsuarioController.sink.add(model.ubicacion ?? '');
  }

  Stream<UsuarioModel> get usuarioStream => _usuarioStreamController.stream;

  UsuarioModel get usuario => _usuarioStreamController.value;
  List<UsuarioModel> get usuarios => _usuariosStreamController.value;

//propiedades usuario
  Stream<String> get idUsuarioStream => _idUsuarioController.stream;
  Stream<String> get nombreUsuarioStream =>
      _nombreUsuarioController.stream.transform(nombreValidator);
  Stream<String> get apellidoUsuarioStream =>
      _apellidoUsuarioController.stream.transform(apellidoValidator);
  Stream<String> get telefonoUsuarioStream =>
      _telefonoUsuarioController.stream.transform(telefonoValidator);
  Stream<String> get ubicacionUsuarioStream =>
      _ubicacionUsuarioController.stream.transform(ubicacionValidator);

  setUbicacionUsuario(String model) {
    _ubicacionUsuarioController.sink.add(model);
  }

  Function(String) get nombreUsuarioSink => _nombreUsuarioController.sink.add;
  Function(String) get apellidoUsuarioSink =>
      _apellidoUsuarioController.sink.add;
  Function(String) get telefonoUsuarioSink =>
      _telefonoUsuarioController.sink.add;
  Function(String) get ubicacionUsuarioSink =>
      _ubicacionUsuarioController.sink.add;

  String get idUsuario => _idUsuarioController.value;
  String get nombreUsuario => _nombreUsuarioController.value;
  String get apellidoUsuario => _apellidoUsuarioController.value;
  String get telefonoUsuario => _telefonoUsuarioController.value;
  String get ubicacionUsuario => _ubicacionUsuarioController.value;

  Stream<bool> get formUsuarioValidStream => Rx.combineLatest3(
      nombreUsuarioStream,
      telefonoUsuarioStream,
      ubicacionUsuarioStream,
      (n, t, u) => true);

  Future<UsuarioModel> getUsuario() async {
    Stream<UsuarioModel> aux = Rx.combineLatest5(
        idUsuarioStream,
        nombreUsuarioStream,
        apellidoUsuarioStream,
        telefonoUsuarioStream,
        ubicacionUsuarioStream, (id, nombre, apellido, telefono, ubicacion) {
      return new UsuarioModel(
          id: id,
          nombre: nombre,
          apellido: apellido,
          telefono: int.parse(telefono),
          ubicacion: ubicacion);
    });
    return await aux.first;
  }

  void estadoCargaSink(bool valor) {
    _estadoCarga.sink.add(valor);
  }

  Stream<bool> get estadoCargaStream => _estadoCarga.stream;

  bool get estadoCarga => _estadoCarga.value;

  void disposeStreams() {
    _usuariosStreamController.close();
    _usuarioStreamController.close();
    _estadoCarga.close();

    _idUsuarioController.close();
    _nombreUsuarioController.close();
    _apellidoUsuarioController.close();
    _telefonoUsuarioController.close();
    _ubicacionUsuarioController.close();
  }
}
