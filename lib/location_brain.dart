import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_data.dart';

class LocationBrain extends ChangeNotifier {
  List<LocationData> data = [];
  List<LatLng> coordinates = [];
  LatLng midpoint;

  void addData(String name, String address, LatLng coordinates) {
    data.add(
        LocationData(name: name, address: address, coordinates: coordinates));
    print('data inserted');
    notifyListeners();
  }

  void addLocation(LatLng points) {
    coordinates.add(points);
    print('location also inserted');
  }

  List<LocationData> getData() {
    return data;
  }

  List<LatLng> getLocationData() {
    return coordinates;
  }

  void deleteEntries(int index) {
    data.removeAt(index);
    coordinates.removeAt(index);
    notifyListeners();
  }

  int getSize() {
    return data.length;
  }
}
