import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/providers/lat_long_stream.dart';
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

  @override
  Widget build(BuildContext context) {
    latLngBloc = BlocProvider.latLngBloc(context);

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
                  latLngBloc.markerSink({
                    new Marker(
                        markerId: MarkerId('seleccion'),
                        position: latLang,
                        infoWindow: InfoWindow(
                          title: 'Ubicacion ',
                          snippet:
                              ' ${latLang.latitude.toStringAsFixed(7)} , ${latLang.longitude.toStringAsFixed(7)} ',
                          onTap: () {
                            Navigator?.pop(context);
                            latLngBloc.latLngSeleccionadoSink(latLang);
                          },
                        ))
                  });
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
}