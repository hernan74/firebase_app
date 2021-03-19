import 'dart:async';

import 'package:fire_base_app/utils/number_utils.dart';

class UsuarioValidator {
  final nombreValidator = new StreamTransformer<String, String>.fromHandlers(
    handleData: (nombre, sink) {
      if (nombre.length >= 3) {
        sink.add(nombre);
      } else {
        sink.addError('Ingrese un nombre');
      }
    },
  );
  final telefonoValidator = new StreamTransformer<String, String>.fromHandlers(
    handleData: (telefono, sink) {
      if (telefono.length >= 6 && isNumeric(telefono)) {
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
