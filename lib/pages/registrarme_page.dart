import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/providers/login/login_stream.dart';
import 'package:fire_base_app/utils/colores.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';
import 'package:fire_base_app/widget/circular_progress_indicator.dart';
import 'package:fire_base_app/widget/crear_snack.dart';
import 'package:fire_base_app/widget/elevate_button.dart';
import 'package:fire_base_app/widget/fondo_personalizado.dart';
import 'package:fire_base_app/widget/textfield_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:fire_base_app/providers/login/login_service_controller.dart';

class RegistroPage extends StatelessWidget {
  final loginController = new LoginServiceController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Nuevo Usuario'),
      ),
      body: Stack(
        children: [
          _crearFondo(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _crearLogin(context),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Center(child: CustomCircularProgressIndicator())
        ],
      ),
    );
  }

  Widget _crearFondo() {
    return Column(
      children: <Widget>[
        FondoPage(),
        Container(
          color: HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
        )
      ],
    );
  }

  Widget _crearLogin(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 1.0,
        color: HexColor.fromHex(ColoresUtils.colorSegundarioFondo)
            .withOpacity(0.95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          height: 400.0,
          width: 360.0,
          child: _crearFormularioLogin(context),
        ),
      ),
    );
  }

  Widget _crearFormularioLogin(BuildContext context) {
    final loginBloc = BlocProvider.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        TextfieldStreamBuilder(
          stream: loginBloc.emailStream,
          sink: loginBloc.emailSink,
          labelText: 'Correo Electronico',
          icon: Icons.alternate_email_outlined,
        ),
        TextfieldStreamBuilder(
            stream: loginBloc.passwordStream,
            sink: loginBloc.passwordSink,
            labelText: 'Contraseña',
            icon: Icons.lock,
            obscureText: true),
        TextfieldStreamBuilder(
            stream: loginBloc.repetirpasswordStream,
            sink: loginBloc.repetirpasswordSink,
            labelText: 'Repetir Contraseña',
            icon: Icons.lock,
            obscureText: true),
        SizedBox(
          width: 200.0,
          child: _crearBotonLogin(context),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget _crearBotonLogin(BuildContext context) {
    final LoginStream bloc = BlocProvider.of(context);

    return StreamBuilder(
        stream: bloc.formRegistroValidStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return CustomButton(
            titulo: 'Registrarme',
            colorBoton: snapshot.hasData
                ? HexColor.fromHex(ColoresUtils.colorPrimarioFondo)
                : Colors.grey.shade400,
            icono: Icons.account_circle_outlined,
            textSize: 18.0,
            onPress: snapshot.hasData
                ? () {
                    _crearUsuario(context, bloc);
                  }
                : null,
          );
        });
  }

  _crearUsuario(BuildContext context, LoginStream bloc) async {
    bloc.estadoLoginSink(false);
    Map<String, dynamic> resp =
        await loginController.registro(bloc.email, bloc.password);

    if (resp['ok'] == true) {
      mostrarSnackBar(context: context, msj: 'Se creo el usuario');
      Navigator.pop(context);
    } else
      mostrarSnackBar(context: context, msj: resp['mensaje'], isError: true);

    print(resp['mensaje']);
    bloc.estadoLoginSink(true);
  }
}
