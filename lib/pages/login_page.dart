import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/providers/login_stream.dart';
import 'package:fire_base_app/widget/crear_snack.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:fire_base_app/providers/login_provider.dart';
import 'package:fire_base_app/utils/colores.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';

class LoginPage extends StatelessWidget {
  final loginController = new LoginServiceController();
  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          ),
          Center(child: _circularProgress(BlocProvider.of(context)))
        ],
      ),
    );
  }

  Widget _circularProgress(LoginStream loginStream) {
    return StreamBuilder(
        initialData: true,
        stream: loginStream.estadoLoginStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data
              ? Container()
              : Container(
                  padding: EdgeInsets.all(20.0),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.black54.withOpacity(0.4)),
                  child: CircularProgressIndicator());
        });
  }

  Widget _crearFondo() {
    return Column(
      children: <Widget>[
        _fondoParteSuperior(),
        Container(
          color: HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
        )
      ],
    );
  }

  Widget _fondoParteSuperior() {
    return Container(
      height: 300.0,
      width: double.maxFinite,
      color: HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: _crearCirulo(3.0),
            top: -40,
            left: 0,
          ),
          Positioned(
            child: _crearCirulo(3.0),
            top: -40,
            left: 100,
          ),
          Positioned(
            child: _crearCirulo(3.0),
            top: -40,
            left: 200,
          ),
          Positioned(
            child: _crearCirulo(3.0),
            top: -40,
            left: 300,
          ),
          Positioned(
            child: _crearCirulo(3.0),
            top: -40,
            left: 400,
          ),
        ],
      ),
    );
  }

  Widget _crearCirulo(double angle) {
    return Transform.rotate(
      angle: -pi / angle,
      child: Container(
          height: 300.0,
          width: 300.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
              HexColor.fromHex(ColoresUtils.colorSegundarioFondo),
            ]),
            borderRadius: BorderRadius.circular(50),
          )),
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
        _crearCampoTexto(
          stream: loginBloc.emailStream,
          sink: loginBloc.emailSink,
          labelText: 'Correo Electronico',
          icon: Icons.alternate_email_outlined,
        ),
        _crearCampoTexto(
            stream: loginBloc.passwordStream,
            sink: loginBloc.passwordSink,
            labelText: 'Contraseña',
            icon: Icons.lock,
            obscureText: true),
        SizedBox(
          width: 200.0,
          child: _crearBotonLogin(context),
        ),
        _crearBotonOlvideClave(),
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

  Widget _crearCampoTexto(
      {@required Stream<String> stream,
      @required Function(String) sink,
      @required String labelText,
      @required IconData icon,
      bool obscureText = false}) {
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
                ),
                border: OutlineInputBorder(),
                labelText: labelText,
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: sink,
          );
        });
  }

  Widget _crearBotonLogin(BuildContext context) {
    final LoginStream bloc = BlocProvider.of(context);

    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    snapshot.hasData
                        ? HexColor.fromHex(ColoresUtils.colorPrimarioFondo)
                        : Colors.grey.shade400)),
            onPressed: snapshot.hasData
                ? () {
                    _login(context, bloc);
                  }
                : null,
            icon: Icon(Icons.login),
            label: Text(
              'Ingresar',
              style: TextStyle(fontSize: 18.0),
            ),
          );
        });
  }

  _login(BuildContext context, LoginStream bloc) async {
    bloc.estadoLoginSink(false);
    Map<String, dynamic> resp =
        await loginController.login(bloc.email, bloc.password);

    if (resp['ok'] == true)
      Navigator.of(context).pushReplacementNamed('/');
    else {
      mostrarSnackBar(context: context, msj: resp['mensaje'], isError: true);
    }
    bloc.estadoLoginSink(true);
  }

  Widget _crearBotonOlvideClave() {
    return SizedBox(
        width: 200.0,
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
