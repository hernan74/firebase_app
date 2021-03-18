import 'dart:async';

import 'package:fire_base_app/validators/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginStream with Validator {
  final _emailController = new BehaviorSubject<String>();
  final _passwordController = new BehaviorSubject<String>();

  final _estadoLogin = new BehaviorSubject<bool>();

  //Cargar valores al stream
  Function(String) get emailSink => _emailController.sink.add;
  Function(String) get passwordSink => _passwordController.sink.add;
  void estadoLoginSink(bool valor) {
    _estadoLogin.sink.add(valor);
  }

  //Escuchar valores del stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get estadoLoginStream => _estadoLogin.stream;

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  String get email => _emailController.value;
  String get password => _passwordController.value;
  bool get estadoLogin => _estadoLogin.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
    _estadoLogin.close();
  }
}
