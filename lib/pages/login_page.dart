import 'dart:math';

import 'package:fire_base_app/utils/colores.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                _crearLogin(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget _crearIconoLogin() {
  //return FaIcon(FontAwesomeIcons.user,size: 250.0,color:  HexColor.fromHex('#CED4DA').withOpacity(0.6),);
//  }

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
            top: -30,
          ),
          Positioned(
            child: _crearCirulo(3.0),
            top: -50,
            right: 0,
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

  Widget _crearLogin() {
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
          child: _crearFormularioLogin(),
        ),
      ),
    );
  }

  Widget _crearFormularioLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Usuario',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Clave',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          width: 200.0,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      HexColor.fromHex(ColoresUtils.colorPrimarioFondo))),
              onPressed: ()  {
                
              },
              child: Text(
                'Ingresar',
                style: TextStyle(fontSize: 18.0),
              )),
        ),
        _crearBotonOlvideClave(),
      ],
    );
  }
}
