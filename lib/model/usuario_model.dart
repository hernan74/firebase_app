import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    UsuarioModel({
        this.id,
        this.nombre,
        this.apellido,
        this.telefono,
        this.direccion,
    });

    String id;
    String nombre;
    String apellido;
    int telefono;
    String direccion;

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id        : json["id"],
        nombre    : json["nombre"],
        apellido  : json["apellido"],
        telefono  : json["telefono"],
        direccion : json["direccion"],
    );

    Map<String, dynamic> toJson() => {
        "id"        : id,
        "nombre"    : nombre,
        "apellido"  : apellido,
        "telefono"  : telefono,
        "direccion" : direccion,
    };
}
