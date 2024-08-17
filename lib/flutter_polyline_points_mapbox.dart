library flutter_polyline_points;

import 'package:flutter_polyline_points_mapbox/flutter_polyline_points_mapbox.dart';
import 'package:flutter_polyline_points_mapbox/src/network_utils.dart';
import 'package:flutter_polyline_points_mapbox/src/utils/polyline_decoder.dart';

export 'src/point_lat_lng.dart';
export 'src/utils/polyline_request.dart';
export 'src/utils/polyline_result.dart';
export 'src/utils/polyline_waypoint.dart';
export 'src/utils/polyline_enums.dart';

class PolylinePoints {
  /// Get the list of coordinates between two geographical positions
  /// which can be used to draw polyline between this two positions
  ///
  Future<PolylineResult> getRouteBetweenCoordinates(
      {required PolylineRequest request, String? mapboxApiKey}) async {
    assert(
        (request.proxy == null &&
                mapboxApiKey != null &&
                mapboxApiKey.isNotEmpty) ||
            (request.proxy != null && mapboxApiKey == null),
        "Google API Key cannot be empty if proxy isn't provided");
    try {
      var result = await NetworkUtil().getRouteBetweenCoordinates(
          request: request, mapboxApiKey: mapboxApiKey);
      return result.isNotEmpty
          ? result[0]
          : PolylineResult(errorMessage: "No result found");
    } catch (e) {
      rethrow;
    }
  }

  /// Get the list of coordinates between two geographical positions with
  /// alternative routes which can be used to draw polyline between this two positions
  Future<List<PolylineResult>> getRouteWithAlternatives(
      {required PolylineRequest request, String? mapboxApiKey}) async {
    assert(
        (request.proxy == null &&
                mapboxApiKey != null &&
                mapboxApiKey.isNotEmpty) ||
            (request.proxy != null && mapboxApiKey == null),
        "Mapbox API Key cannot be empty if proxy isn't provided");
    assert(request.arrivalTime == null || request.departureTime == null,
        "You can only specify either arrival time or departure time");
    try {
      return await NetworkUtil().getRouteBetweenCoordinates(request: request, mapboxApiKey: mapboxApiKey);
    } catch (e) {
      rethrow;
    }
  }

  List<PointLatLng> decodePolyline(List<dynamic> encodedString) {
    return PolylineDecoder.run(encodedString);
  }
}
