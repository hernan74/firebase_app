import 'package:fire_base_app/utils/colores.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';
import 'package:flutter/material.dart';

class TextfieldStreamBuilder extends StatelessWidget {
  final Stream<String> stream;
  final Function(String) sink;
  final String labelText;
  final String valor;
  final IconData icon;
  final bool obscureText;

  TextfieldStreamBuilder(
      {@required this.stream,
      @required this.sink,
      @required this.labelText,
      @required this.icon,
      @required this.valor,
      this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextFormField(
            initialValue: valor,
            obscureText: obscureText,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
                ),
                border: OutlineInputBorder(),
                labelText: labelText,
                errorText: snapshot.error),
            onChanged: sink,
          );
        });
  }
}
