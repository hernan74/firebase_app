import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/model/usuario_model.dart';
import 'package:fire_base_app/providers/usuarios/usuarios_service_controller.dart';
import 'package:fire_base_app/utils/colores.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';
import 'package:fire_base_app/widget/circular_progress_indicator.dart';
import 'package:fire_base_app/widget/elevate_button.dart';
import 'package:fire_base_app/widget/rating.dart';
import 'package:fire_base_app/widget/textfield_stream_builder.dart';
import 'package:flutter/material.dart';

class FichaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioStream = BlocProvider.usuariosBloc(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha'),
      ),
      body: StreamBuilder(
          stream: usuarioStream.estadoCargaStream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return IgnorePointer(
              ignoring: snapshot.hasData ? !snapshot.data : false,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        _crearFormulario(context),
                        CustomCircularProgressIndicator(
                          progreso: usuarioStream.estadoCargaStream,
                          child: Container(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _crearFormulario(BuildContext context) {
    final usuarioStream = BlocProvider.usuariosBloc(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextfieldStreamBuilder(
                stream: usuarioStream.nombreUsuarioStream,
                sink: usuarioStream.nombreUsuarioSink,
                labelText: 'Nombre',
                valor: usuarioStream.nombreUsuario,
                icon: Icons.account_circle_outlined),
            SizedBox(
              height: 10.0,
            ),
            TextfieldStreamBuilder(
                stream: usuarioStream.apellidoUsuarioStream,
                sink: usuarioStream.apellidoUsuarioSink,
                valor: usuarioStream.apellidoUsuario,
                labelText: 'Apellido',
                icon: Icons.account_circle_outlined),
            SizedBox(
              height: 10.0,
            ),
            TextfieldStreamBuilder(
                stream: usuarioStream.telefonoUsuarioStream,
                sink: usuarioStream.telefonoUsuarioSink,
                valor: usuarioStream.telefonoUsuario,
                labelText: 'Telefono',
                icon: Icons.phone),
            SizedBox(
              height: 10.0,
            ),
            _campoMapa(context),
            SizedBox(
              height: 10.0,
            ),
            TextfieldStreamBuilder(
                stream: usuarioStream.observacionesUsuarioStream,
                sink: usuarioStream.observacionesUsuarioSink,
                valor: usuarioStream.observacionesUsuario,
                labelText: 'Observaciones',
                icon: Icons.info),
            SizedBox(
              height: 15.0,
            ),
            _crearCampoRating(context),
            SizedBox(
              height: 15.0,
            ),
            _guardar(
              context,
            )
          ],
        ),
      ),
    );
  }

  Widget _crearCampoRating(BuildContext context) {
    final usuarioStream = BlocProvider.usuariosBloc(context);
    return Column(
      children: [
        Text(
          'Calificacion',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        RatingCincoEstrellasWidget(
          ratingStream: usuarioStream.calificacionUsuarioStream,
          ratingSink: usuarioStream.calificacionUsuarioSink,
        ),
      ],
    );
  }

  Widget _guardar(
    BuildContext context,
  ) {
    final usuarioStream = BlocProvider.usuariosBloc(context);
    final latLngStream = BlocProvider.latLngBloc(context);
    final usuarioService = new UsuarioServiceController(context);
    return StreamBuilder(
        stream: usuarioStream.formUsuarioValidStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return CustomButton(
            titulo: 'Guardar',
            colorBoton: snapshot.hasData
                ? snapshot.data
                    ? HexColor.fromHex(ColoresUtils.colorPrimarioFondo)
                    : Colors.grey.shade400
                : Colors.grey.shade400,
            icono: Icons.save,
            textSize: 18.0,
            onPress: snapshot.hasData
                ? snapshot.data
                    ? () async {
                        bool resp;
                        if (usuarioStream.idUsuario?.isEmpty ?? true) {
                          resp = await usuarioService
                              .nuevo(await usuarioStream.getUsuario());
                        } else {
                          resp = await usuarioService
                              .modificar(await usuarioStream.getUsuario());
                        }
                        if (resp) {
                          usuarioStream.usuarioUsuario = new UsuarioModel();
                          latLngStream.latLngSeleccionadoSink(null);
                          latLngStream.marker?.clear();
                          Navigator.pop(context);
                        }
                      }
                    : null
                : null,
          );
        });
  }

  Widget _campoMapa(BuildContext context) {
    final usuariosStream = BlocProvider.usuariosBloc(context);
    print(UsuarioModel.getLatLgnCorto(usuariosStream.ubicacionUsuario));
    return StreamBuilder(
        stream: usuariosStream.ubicacionUsuarioStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            controller: TextEditingController(
              text:
                  UsuarioModel.getLatLgnCorto(usuariosStream.ubicacionUsuario),
            ),
            enableInteractiveSelection: false,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              Navigator.of(context).pushNamed('mapa');
            },
            decoration: InputDecoration(
                labelText: 'Click para abrir mapa',
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
                ),
                border: OutlineInputBorder(),
                errorText: snapshot?.error),
          );
        });
  }
}
