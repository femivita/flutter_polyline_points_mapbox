
import '../point_lat_lng.dart';

/// description:
/// project: flutter_polyline_points_mapbox
/// @package:
/// @author: femivita
/// created on: 17/08/2024
class PolylineResult {
  /// the api status retuned from mapbox api
  ///
  /// returns OK if the api call is successful
  String? status;

  /// list of decoded points
  List<PointLatLng> points;

  /// the error message returned from mapbox, if none, the result will be empty
  String? errorMessage;

  PolylineResult(
      {this.status,
      this.points = const [],
      this.errorMessage = "",
      });
}
