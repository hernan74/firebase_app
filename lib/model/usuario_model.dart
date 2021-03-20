import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  UsuarioModel({
    this.id,
    this.nombre,
    this.apellido,
    this.telefono,
    this.ubicacion,
  });

  String id;
  String nombre;
  String apellido;
  int telefono;
  String ubicacion;

  LatLng getLatLgn() {
    if (this.ubicacion == null) return null;

    final latLng = this.ubicacion.split(',');
    if (latLng.isEmpty || latLng.length != 2) return null;
    final lat = double.parse(latLng[0] ?? '0.0');
    final lng = double.parse(latLng[1] ?? '0.0');

    return LatLng(lat, lng);
  }

  static String getLatLgnCorto(String latLgn) {
    if (latLgn == null) return '';
    final latLngAux = latLgn.split(',');
    if (latLngAux.length == 2)
      return '${latLngAux[0]?.substring(0, 10)}, ${latLngAux[1]?.substring(0, 10)} ';
    else
      return '';
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        ubicacion: json["ubicacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
        "ubicacion": ubicacion,
      };
}
