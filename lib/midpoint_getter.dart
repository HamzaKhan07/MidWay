import 'dart:math' as math;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MidpointGetter {
  LatLng getCenterLatLong(List<LatLng> latLongList) {
    double pi = math.pi / 180;
    double xpi = 180 / math.pi;
    double x = 0, y = 0, z = 0;

    if (latLongList.length == 1) {
      return latLongList[0];
    }
    for (int i = 0; i < latLongList.length; i++) {
      double latitude = latLongList[i].latitude * pi;
      double longitude = latLongList[i].longitude * pi;
      double c1 = math.cos(latitude);
      x = x + c1 * math.cos(longitude);
      y = y + c1 * math.sin(longitude);
      z = z + math.sin(latitude);
    }

    int total = latLongList.length;
    x = x / total;
    y = y / total;
    z = z / total;

    double centralLongitude = math.atan2(y, x);
    double centralSquareRoot = math.sqrt(x * x + y * y);
    double centralLatitude = math.atan2(z, centralSquareRoot);

    return LatLng(centralLatitude * xpi, centralLongitude * xpi);
  }
}
