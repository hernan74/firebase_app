import 'package:fire_base_app/pages/registrarme_page.dart';
import 'package:flutter/material.dart';
import 'package:fire_base_app/pages/mapa_page.dart';
import 'package:fire_base_app/preferencia_usuario/preferencia_usuario.dart';
import 'package:fire_base_app/utils/colores.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';
import 'package:fire_base_app/pages/home_page.dart';
import 'package:fire_base_app/pages/login_page.dart';
import 'package:fire_base_app/pages/ficha_usuario.dart';

import 'bloc/bloc_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fire Base',
        initialRoute: '/',
        routes: {
          '/': (_) => HomePage(),
          'login': (_) => LoginPage(),
          'ficha': (_) => FichaPage(),
          'mapa': (_) => MapaPage(),
          'registro': (_) => RegistroPage(),
        },
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor:
                  HexColor.fromHex(ColoresUtils.colorPrimarioFondo)),
          primaryColor: HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
          secondaryHeaderColor:
              HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
        ),
      ),
    );
  }
}
