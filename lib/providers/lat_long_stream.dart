import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class LatLngStream {
  final _latLngSeleccionado = new BehaviorSubject<LatLng>();
  final _zoomMapa = new BehaviorSubject<double>();
  final _marker = new BehaviorSubject<Set<Marker>>();

  //Cargar valores al stream
  latLngSeleccionadoSink(LatLng latLng) {
    _latLngSeleccionado.sink.add(latLng);
  }

  //Escuchar valores del stream
  Stream<LatLng> get latLngSeleccionadoStream => _latLngSeleccionado.stream;

  String truncarLatLong(LatLng latLng) {
    if (latLng == null)
      return '';
    else
      return ' ${latLng.latitude.toStringAsFixed(7)} , ${latLng.longitude.toStringAsFixed(7)} ';
  }

  LatLng get latLngSeleccionadoValue =>
      _latLngSeleccionado.value ?? new LatLng(-26.411671, -54.583593);

  Stream<Set<Marker>> get markerStream => _marker.stream;

  void markerSink(Set<Marker> marker) {
    this._marker.sink.add(marker);
  }

  Set<Marker> get marker => _marker?.value;

  Stream<double> get zoomMapaStream => _zoomMapa.stream;

  void zoomMapaSink(double zoom) {
    this._zoomMapa.sink.add(zoom);
  }

  double get zoom => _zoomMapa?.value;

  dispose() {
    _latLngSeleccionado.close();
    _marker.close();
    _zoomMapa.close();
  }
}
