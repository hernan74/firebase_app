import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String titulo;
  final double textSize;
  final IconData icono;
  final Color colorBoton;
  final Color colorTexto;
  final Function() onPress;
  CustomButton(
      {@required this.titulo,
      this.textSize = 18,
      this.icono,
      this.colorBoton,
      this.colorTexto = Colors.white,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(colorBoton)),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (icono != null) Icon(icono, color: colorTexto),
          Text(
            titulo,
            style: TextStyle(fontSize: textSize, color: colorTexto),
          )
        ],
      ),
    );
  }
}
