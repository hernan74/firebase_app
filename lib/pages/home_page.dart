import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/model/usuario_model.dart';
import 'package:fire_base_app/pages/lista_usarios_page.dart';
import 'package:fire_base_app/widget/menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: Text('Conexion a FireBase'),
      ),
      body: ListaUsuarioPage(),
      floatingActionButton: _crearFloatingActionButton(context),
    );
  }

  Widget _crearFloatingActionButton(BuildContext context) {
    final usuarioStream = BlocProvider.usuariosBloc(context);
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          usuarioStream.usuarioUsuario = new UsuarioModel();
          Navigator.of(context).pushNamed('ficha');
        });
  }
}
