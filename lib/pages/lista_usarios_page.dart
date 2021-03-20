import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/model/usuario_model.dart';
import 'package:fire_base_app/providers/usuarios/usuarios_service_controller.dart';
import 'package:fire_base_app/providers/usuarios/usuarios_stream.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';
import 'package:fire_base_app/widget/circular_progress_indicator.dart';
import 'package:fire_base_app/widget/crear_snack.dart';
import 'package:fire_base_app/widget/elevate_button.dart';
import 'package:flutter/material.dart';

class ListaUsuarioPage extends StatefulWidget {
  @override
  _ListaUsuarioPageState createState() => _ListaUsuarioPageState();
}

class _ListaUsuarioPageState extends State<ListaUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.usuariosBloc(context);
    final usuarioService = new UsuarioServiceController(context);

    usuarioService.buscarTodos();

    return Center(
      child: CustomCircularProgressIndicator(
        progreso: provider.estadoCargaStream,
        child: _cargarListadoUsuario(provider,context),
      ),
    );
  }

  Widget _cargarListadoUsuario(UsuariosStream provider,BuildContext buildContext) {
    return StreamBuilder(
        stream: provider.usuariosStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: _crearItem(snapshot.data[i], buildContext),
                  );
                });
          } else {
            return Center(
              child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.black54.withOpacity(0.4)),
                  child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget _crearItem(UsuarioModel model, BuildContext context) {
    final usuarioStream = BlocProvider.usuariosBloc(context);
    final usuarioService = new UsuarioServiceController(context);
    final uniqueKey = UniqueKey();
    return Dismissible(
        background: Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: AlignmentDirectional.centerStart,
          height: 100.0,
          width: 100.0,
          child: Icon(
            Icons.delete_outline_rounded,
            size: 50.0,
            color: Colors.white,
          ),
          color: Colors.red,
        ),
        secondaryBackground: Container(
          padding: EdgeInsets.only(right: 10.0),
          alignment: AlignmentDirectional.centerEnd,
          height: 100.0,
          width: 100.0,
          child: Icon(
            Icons.edit,
            size: 50.0,
            color: Colors.white,
          ),
          color: Colors.blue,
        ),
        key: uniqueKey,
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.startToEnd) {
            return await _mensajeConfirmacion(context);
          } else {
            usuarioStream.usuarioUsuario = model;
            Navigator.of(context).pushNamed('ficha');
            return false;
          }
        },
        onDismissed: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            if (await usuarioService.eliminar(model.id)) setState(() {});
            mostrarSnackBar(context: context, msj: 'Se elimino el usuario');
          }
        },
        child: GestureDetector(
            onTap: () {
              usuarioStream.usuarioUsuario = model;
              Navigator.of(context).pushNamed('ficha');
            },
            child: _crearContenidoItem(model)));
  }

  Future<bool> _mensajeConfirmacion(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Accion"),
          content: const Text("¿Esta seguro de eliminar el usuario?"),
          actions: <Widget>[
            CustomButton(
                titulo: 'Confirmar',
                withBoton: 120.0,
                onPress: () => Navigator.of(context).pop(true)),
            CustomButton(
                titulo: 'Cancelar',
                withBoton: 110.0,
                onPress: () => Navigator.of(context).pop(false)),
          ],
        );
      },
    );
  }

  Widget _crearContenidoItem(UsuarioModel model) {
    TextStyle tituloStyle = TextStyle(fontSize: 18, color: Colors.black45);
    TextStyle contenidoStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: HexColor.fromHex('#1F1F1F'));
    return Card(
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 90.0,
                  width: 90.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12.withOpacity(0.1)),
                  ),
                  child: _crearIcono(Icons.account_circle_outlined, 50.0),
                ),
                _crearCampoUsuario(model, tituloStyle, contenidoStyle),
              ],
            ),
          ),
          Divider(),
          Text(
            'Ubicacion',
            style: tituloStyle,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _crearCampoLatLgn(
                      'Longitud', model.getLatLgn().longitude, tituloStyle),
                  _crearCampoLatLgn(
                      'Latitud', model.getLatLgn().latitude, tituloStyle)
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                child: GestureDetector(
                    onTap: () {
                      final usuarioStream = BlocProvider.usuariosBloc(context);
                      usuarioStream.usuarioUsuario = model;
                      Navigator.of(context).pushNamed('mapa');
                    },
                    child: _crearIcono(Icons.map_outlined, 40.0)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _crearIcono(IconData icono, double size) {
    return Icon(
      icono,
      color: Colors.black54,
      size: size,
    );
  }

  Widget _crearCampoLatLgn(String latLgn, double valor, TextStyle style) {
    return Row(
      children: <Widget>[
        _crearIcono(Icons.location_on_outlined, 18.0),
        Text('$latLgn: '),
        Text(
          '$valor ',
          style: style,
        ),
      ],
    );
  }

  _crearCampoUsuario(
      UsuarioModel model, TextStyle tituloStyle, TextStyle contenidoStyle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Usuario',
            style: tituloStyle,
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '  ${model.nombre} ${model.apellido}',
                style: contenidoStyle,
              ),
              Text(
                '   Telefono: ${model.telefono} ',
                style: tituloStyle,
              ),
              Divider(
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
