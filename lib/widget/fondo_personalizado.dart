import 'dart:math';

import 'package:fire_base_app/utils/colores.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';
import 'package:flutter/material.dart';

class FondoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
