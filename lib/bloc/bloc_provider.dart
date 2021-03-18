import 'package:fire_base_app/providers/login_stream.dart';
import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final loginStream = new LoginStream();

  static BlocProvider _instancia;

  factory BlocProvider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new BlocProvider._internal(key: key, child: child);
    }
    return _instancia;
  }

  BlocProvider._internal({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginStream of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BlocProvider>()
        .loginStream;
  }
}
