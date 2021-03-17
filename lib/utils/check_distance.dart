import 'dart:math';
import 'package:places/data/model/geo_position.dart';

/// Checks if the point [checkPoint] is in the radius
/// user location [imHere] and conditions specified by it
/// [minDistance] and [maxDistance] in meters.
class DistanceToPlace {
  double check({
    GeoPosition checkPoint,
    GeoPosition userPoint,
    double minDistance,
    double maxDistance,
  }) {
    const double ky = 40000000 / 360;
    final double kx = cos(pi * checkPoint.lat / 180.0) * ky;
    final double dx = (checkPoint.lng - userPoint.lng).abs() * kx;
    final double dy = (checkPoint.lat - userPoint.lat).abs() * ky;
    final double distance = sqrt(dx * dx + dy * dy);
    //return distance >= minDistance && distance <= maxDistance;
    return distance;
  }
}
