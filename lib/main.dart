import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:fire_base_app/preferencia_usuario/preferencia_usuario.dart';
import 'package:fire_base_app/providers/login_provider.dart';
import 'package:fire_base_app/pages/home_page.dart';
import 'package:fire_base_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fire Base',
        initialRoute: 'login',
        routes: {'/': (_) => HomePage(), 'login': (_) => LoginPage()},
      ),
    );
  }
}
