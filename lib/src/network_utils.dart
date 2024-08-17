import 'dart:convert';
import 'dart:developer';

import 'package:flutter_polyline_points_mapbox/src/utils/polyline_decoder.dart';
import 'package:flutter_polyline_points_mapbox/src/utils/polyline_request.dart';
import 'package:http/http.dart' as http;

import 'utils/polyline_result.dart';

class NetworkUtil {
  static const String STATUS_OK = "ok";

  ///Get the encoded string from mapbox directions api
  ///
  Future<List<PolylineResult>> getRouteBetweenCoordinates({
    required PolylineRequest request,
    String? mapboxApiKey,
  }) async {
    Map<String, String> params = {
      "origin": "${request.origin.longitude}%2C${request.origin.latitude}",
      "destination":
          "${request.destination.longitude}%2C${request.destination.latitude}",
      "mode": request.mode.name,
      "key": mapboxApiKey!
    };
    List<PolylineResult> results = [];
    Uri uri = Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/${params['mode']}/${params['origin']}%3B${params['destination']}?alternatives=true&geometries=geojson&overview=full&steps=false&access_token=${params['key']}');

    var response = await http.get(
      uri,
      headers: request.headers,
    );
    log(response.body);
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      if (parsedJson["code"]?.toLowerCase() == STATUS_OK &&
          parsedJson["routes"] != null &&
          parsedJson["routes"].isNotEmpty) {
        List<dynamic> routeList = parsedJson["routes"];
        for (var route in routeList) {
          results.add(PolylineResult(
            points: PolylineDecoder.run(route["geometry"]["coordinates"]),
            errorMessage: "",
            status: parsedJson["code"],
          ));
        }
      } else {
        throw Exception(
            "Unable to get route: Response ---> ${parsedJson["code"]} ");
      }
    }
    return results;
  }
}
