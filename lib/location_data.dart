import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationData {
  final String name;
  final String address;
  final LatLng coordinates;

  LocationData({this.name, this.address, this.coordinates});
}
