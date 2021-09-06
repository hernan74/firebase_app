import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/providers/lat_long_stream.dart';
import 'package:fire_base_app/providers/usuarios/usuarios_stream.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLngStream latLngBloc;
  UsuariosStream usuariosStream;

  @override
  Widget build(BuildContext context) {
    latLngBloc = BlocProvider.latLngBloc(context);
    usuariosStream = BlocProvider.usuariosBloc(context);
    final ubicacionUsuario = usuariosStream.usuario.getLatLgn();
    latLngBloc.latLngSeleccionadoSink(ubicacionUsuario);
    if (ubicacionUsuario != null)
      latLngBloc.markerSink({_agregarMarker(ubicacionUsuario)});
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.0),
        ),
        body: StreamBuilder(
            stream: latLngBloc.markerStream,
            builder: (BuildContext buildContext,
                AsyncSnapshot<Set<Marker>> snapshot) {
              return GoogleMap(
                mapType: MapType.normal,
                markers: snapshot.hasData ? snapshot.data : null,
                initialCameraPosition: CameraPosition(
                  target: latLngBloc.latLngSeleccionadoValue ??
                      new LatLng(-26.411671, -54.583593),
                  zoom: latLngBloc.zoom ?? 14.4746,
                ),
                onTap: (latLang) {
                  latLngBloc.marker?.clear();
                  latLngBloc.markerSink({_agregarMarker(latLang)});
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMove: (posision) {
                  latLngBloc.zoomMapaSink(posision.zoom);
                },
              );
            }));
  }

  Marker _agregarMarker(LatLng latLng) {
    return new Marker(
        markerId: MarkerId('seleccion'),
        position: latLng,
        infoWindow: InfoWindow(
          title: 'Ubicacion ',
          snippet:
              ' ${latLng.latitude.toStringAsFixed(7)} , ${latLng.longitude.toStringAsFixed(7)} ',
          onTap: () {
            if (!mounted) return;
            Navigator?.pop(context);
            latLngBloc.latLngSeleccionadoSink(latLng);
            usuariosStream.setUbicacionUsuario(
                '${latLng.latitude},' '${latLng.longitude}');
          },
        ));
  }
}
