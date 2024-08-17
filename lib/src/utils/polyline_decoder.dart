import 'package:flutter_polyline_points_mapbox/src/point_lat_lng.dart';


class PolylineDecoder {
  static List<PointLatLng> run(List<dynamic> encoded) {
    List<PointLatLng> points = [];

    for (var i = 0; i < encoded.length; i++) {
      points.add(PointLatLng(encoded[i][0], encoded[i][1]));
    }

    return points;
  }
}
