import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/utils/colores.dart';
import 'package:fire_base_app/utils/hex_color_util.dart';
import 'package:fire_base_app/widget/elevate_button.dart';
import 'package:fire_base_app/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FichaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _crearFormulario(context),
        ),
      ),
    );
  }

  Widget _crearFormulario(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomTextfield(
                iconoPrefix: Icons.account_circle_outlined,
                tituloLabel: 'Nombre'),
            SizedBox(
              height: 10.0,
            ),
            CustomTextfield(
                iconoPrefix: Icons.account_circle_outlined,
                tituloLabel: 'Apellido'),
            SizedBox(
              height: 10.0,
            ),
            CustomTextfield(iconoPrefix: Icons.phone, tituloLabel: 'Telefono'),
            SizedBox(
              height: 10.0,
            ),
            _campoMapa(context),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 150.0,
              child: CustomButton(
                titulo: 'Guardar',
                icono: Icons.save,
                colorBoton: HexColor.fromHex(ColoresUtils.colorPrimarioFondo),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _campoMapa(BuildContext context) {
    final latLngBloc = BlocProvider.latLngBloc(context);
    return StreamBuilder(
        stream: latLngBloc.latLngSeleccionadoStream,
        builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
          return TextField(
              enableInteractiveSelection: false,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                Navigator.of(context).pushNamed('mapa');
              },
              controller: TextEditingController(
                  text: snapshot.hasData
                      ? latLngBloc.truncarLatLong(snapshot.data)
                      : ''),
              decoration: InputDecoration(
                labelText: 'Ubicacion',
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                ),
                suffix: GestureDetector(onTap: () {}, child: Icon(Icons.map)),
                border: OutlineInputBorder(),
              ));
        });
  }
}
