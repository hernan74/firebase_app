import 'dart:async';

import 'package:fire_base_app/utils/number_utils.dart';

class UsuarioValidator {
  final nombreValidator = new StreamTransformer<String, String>.fromHandlers(
    handleData: (nombre, sink) {
      if (nombre == null || nombre.length >= 3 && nombre.length <= 25) {
        sink.add(nombre);
      } else {
        sink.addError('Ingrese un nombre');
      }
    },
  );
  final apellidoValidator = new StreamTransformer<String, String>.fromHandlers(
    handleData: (apellido, sink) {
      if (apellido == null || apellido.length <= 15) {
        sink.add(apellido);
      } else {
        sink.addError('El apellido es muy largo');
      }
    },
  );
  final telefonoValidator = new StreamTransformer<String, String>.fromHandlers(
    handleData: (telefono, sink) {
      if (telefono == null ||
          telefono.length >= 6 &&
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
      if (ubicacion == null || ubicacion.length >= 6) {
        sink.add(ubicacion);
      } else {
        sink.addError('Seleccione una ubicacion');
      }
    },
  );
}
