import 'package:fire_base_app/widget/fondo_personalizado.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(0),
            child: FondoPage(),
          ),
          _crearItem(Icons.home, 'Inicio', () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/');
          }),
          Divider(),
          _crearItem(Icons.supervisor_account_outlined, 'Crear Usuario', () {
            Navigator.pop(context);

            Navigator.pushNamed(context, 'registro');
          }),
          Divider(),
        ],
      ),
    );
  }

  Widget _crearItem(IconData icon, String titulo, Function onTap) {
    return ListTile(
      title: Text(titulo),
      leading: Icon(
        icon,
        color: Colors.blueAccent,
      ),
      onTap: onTap,
    );
  }
}
