import 'package:fire_base_app/preferencia_usuario/preferencia_usuario.dart';
import 'package:fire_base_app/providers/login_service.dart';

class LoginServiceController {
  final loginProvider = new LoginService();
  final _prefs = new PreferenciasUsuario();
  Future<Map<String, dynamic>> login(String email, String clave) async {
    Map<String, dynamic> resp =
        await loginProvider.login(email: email, password: clave);
    if (resp['ok'] == true) {
      _prefs.token = resp['mensaje'];
      return resp;
    } else {
      _prefs.token = '';
      return resp;
    }
  }
}
