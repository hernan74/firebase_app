import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String tituloLabel;
  final IconData iconoPrefix;
  final Widget iconoSufix;
  final bool campoEditable;
  CustomTextfield(
      {this.tituloLabel,
      this.iconoPrefix,
      this.iconoSufix,
      this.campoEditable = true});

  @override
  Widget build(BuildContext context) {
    return TextField(
        enableInteractiveSelection: campoEditable,
        decoration: InputDecoration(
          labelText: tituloLabel,
          prefixIcon: Icon(
            iconoPrefix,
          ),
          suffix: iconoSufix,
          border: OutlineInputBorder(),
        ));
  }
}
