import 'dart:async';

import 'file:///D:/Usuarios/Soporte/Documents/Flutter_Projects/fire_base_app/number_utils.dart';

class UsuarioValidator {
  final nombreValidator = new StreamTransformer<String, String>.fromHandlers(
    handleData: (nombre, sink) {
      if (nombre.length >= 3 && nombre.length <= 25) {
        sink.add(nombre);
      } else {
        sink.addError('Ingrese un nombre');
      }
    },
  );
  final apellidoValidator = new StreamTransformer<String, String>.fromHandlers(
    handleData: (nombre, sink) {
      if (nombre.length <= 15) {
        sink.add(nombre);
      } else {
        sink.addError('El apellido es muy largo');
      }
    },
  );
  final telefonoValidator = new StreamTransformer<String, String>.fromHandlers(
    handleData: (telefono, sink) {
      if (telefono.length >= 6 &&
          telefono.length <= 15 &&
          isNumeric(telefono)) {
        sink.add(telefono);
      } else {
        sink.addError('ingrese un numero de telefono');
      }
    },
  );
  final ubicacionValidator = new StreamTransformer<String, String>.fromHandlers(
    handleData: (ubicacion, sink) {
      if (ubicacion.length >= 6) {
        sink.add(ubicacion);
      } else {
        sink.addError('Seleccione una ubicacion');
      }
    },
  );
}
