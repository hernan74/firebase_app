import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/providers/login/login_stream.dart';
import 'package:fire_base_app/widget/circular_progress_indicator.dart';
import 'package:fire_base_app/widget/crear_snack.dart';
import 'package:fire_base_app/widget/elevate_button.dart';
import 'package:fire_base_app/widget/fondo_personalizado.dart';
import 'package:fire_base_app/widget/textfield_stream_builder.dart';
import 'package:flutter/material.dart';

import 'package:fire_base_app/providers/login/login_service_controller.dart';
import 'package:fire_base_app/utils/colores.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';

class LoginPage extends StatelessWidget {
  final loginController = new LoginServiceController();
  @override
  Widget build(BuildContext context) {
    final LoginStream loginStream = BlocProvider.of(context);
    return Scaffold(
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
                _crearBotonOlvideClave(),
              ],
            ),
          ),
          Center(
              child: CustomCircularProgressIndicator(
            progreso: loginStream.estadoLoginStream,
            child: Container(),
          ))
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
        _crearIconoLogin(),
        SizedBox(
          height: 10.0,
        ),
        TextfieldStreamBuilder(
          stream: loginBloc.emailStream,
          sink: loginBloc.emailSink,
          valor: loginBloc.email,
          labelText: 'Correo Electronico',
          icon: Icons.alternate_email_outlined,
        ),
        TextfieldStreamBuilder(
            stream: loginBloc.passwordStream,
            sink: loginBloc.passwordSink,
            valor: loginBloc.password,
            labelText: 'Contraseña',
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

  Widget _crearIconoLogin() {
    return Column(
      children: [
        Icon(
          Icons.account_circle_outlined,
          size: 70.0,
          color: HexColor.fromHex('#CED4DA').withOpacity(0.9),
        ),
        Text(
          'Inicie Sesion',
          style: TextStyle(
              color: HexColor.fromHex('#CED4DA').withOpacity(0.9),
              fontWeight: FontWeight.bold,
              fontSize: 40.0),
        )
      ],
    );
  }

  Widget _crearBotonLogin(BuildContext context) {
    final LoginStream bloc = BlocProvider.of(context);

    return StreamBuilder(
        stream: bloc.formLoginValidStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return CustomButton(
            titulo: 'Ingresar',
            colorBoton: snapshot.hasData
                ? HexColor.fromHex(ColoresUtils.colorPrimarioFondo)
                : Colors.grey.shade400,
            icono: Icons.login,
            textSize: 18.0,
            onPress: snapshot.hasData
                ? () {
                    _login(context, bloc);
                  }
                : null,
          );
        });
  }

  _login(BuildContext context, LoginStream bloc) async {
    bloc.estadoLoginSink(false);
    Map<String, dynamic> resp =
        await loginController.login(bloc.email, bloc.password);

    if (resp['ok'] == true) {
      Navigator.of(context).pushReplacementNamed('/');
      bloc.setemailSink('');
      bloc.setPasswordSink('');
    } else
      mostrarSnackBar(context: context, msj: resp['mensaje'], isError: true);

    print(resp['mensaje']);
    bloc.estadoLoginSink(true);
  }

  Widget _crearBotonOlvideClave() {
    return SizedBox(
        width: 250.0,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    HexColor.fromHex('#fafafa')),
                elevation: MaterialStateProperty.all<double>(0.0)),
            onPressed: () {},
            child: Text(
              'Olvide mi contraseña',
              style: TextStyle(color: Colors.black45, fontSize: 18.0),
            )));
  }
}
