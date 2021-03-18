import 'dart:async';

import 'package:fire_base_app/validators/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginStream with Validator {
  final _emailController = new BehaviorSubject<String>();
  final _passwordController = new BehaviorSubject<String>();
  final _repetirpasswordController = new BehaviorSubject<String>();

  final _estadoLogin = new BehaviorSubject<bool>();

  //Cargar valores al stream
  Function(String) get emailSink => _emailController.sink.add;
  void setemailSink(String email) => _emailController.sink.add(email);
  Function(String) get passwordSink => _passwordController.sink.add;
  Function(String) get repetirpasswordSink =>
      _repetirpasswordController.sink.add;

  void setPasswordSink(String pass) => _passwordController.sink.add(pass);

  void estadoLoginSink(bool valor) {
    _estadoLogin.sink.add(valor);
  }

  //Escuchar valores del stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);

  Stream<String> get repetirpasswordStream => _repetirpasswordController.stream
          .transform(passwordValidator)
          .doOnData((String c) {
        if (0 != _passwordController.value.compareTo(c)) {
          _repetirpasswordController.addError("Las contraseñas no coinciden");
        }
      });

  Stream<bool> get estadoLoginStream => _estadoLogin.stream;

  Stream<bool> get formLoginValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Stream<bool> get formRegistroValidStream => Rx.combineLatest3(
      emailStream, passwordStream, repetirpasswordStream, (e, p, r) => true);

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get repetirpassword => _repetirpasswordController.value;

  bool get estadoLogin => _estadoLogin.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
    _repetirpasswordController.close();
    _estadoLogin.close();
  }
}
