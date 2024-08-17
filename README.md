# flutter_polyline_points_mapbox

A flutter plugin that decodes encoded mapbox polyline string into list of geo-coordinates suitable for showing route/polyline on maps


## Getting Started

This package contains functions to decode google encoded polyline string which returns a list of co-ordinates
indicating route between two geographical position

## Usage

To use this package, add flutter_polyline_points_mapbox as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

## Import the package

```dart
import 'package:flutter_polyline_points_mapbox/flutter_polyline_points_mapbox.dart';
```

## First method

Get the list of points by Geo-coordinate, this return an instance of PolylineResult, which
contains the status of the api, the errorMessage, and the list of decoded points.

```dart
PolylinePoints polylinePoints = PolylinePoints();
PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        mapboxApiKey: mapboxApiKey,
        request: PolylineRequest(
        origin: PointLatLng(_originLatitude, _originLongitude),
        destination: PointLatLng(_destLatitude, _destLongitude),
        mode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Itire/Ikate, Surulere. Lagos.")],
        ),
);
print(result.points);
```

## Second method

Fetch polyline with alternative routes. This method returns a list of PolylineResult

```dart
List<PolylineResult> resulte = await PolylinePoints().getRouteBetweenCoordinates(
      mapboxApiKey: mapboxApiKey,
      request: PolylineRequest(
        origin: PointLatLng(_originLatitude, _originLongitude),
        destination: PointLatLng(_destLatitude, _destLongitude),
        mode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Itire/Ikate, Surulere. Lagos.")],
      ),
    );
print(results.length);
```

See the example directory for a complete sample app

## Hint

kindly ensure you use a valid google api key,  
[If you need help generating api key for your project click this link, login?signup and generate a free token](https://account.mapbox.com)