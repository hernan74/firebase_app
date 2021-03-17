import 'package:fire_base_app/model/login_model.dart';
import 'package:fire_base_app/providers/login_service.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final loginProvider = new LoginService();

  String _token = '';
  bool _seLogeo = false;
  LoginModel _loginModel = new LoginModel();

  get loginModel => _loginModel;
  get token => _token;
  get seLogeo => _seLogeo;

  void login({String email, String clave}) async {
    Map<String, dynamic> resp = await loginProvider.login(
        email: 'hernan@gmail.com', password: '123456');
    if (resp['ok'] == true) {
      _token = resp['token'];
      _seLogeo = true;
    } else {
      _token = resp['mensaje'];
      _seLogeo = false;
    }
    notifyListeners();
  }
}
