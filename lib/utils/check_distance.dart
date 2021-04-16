import 'dart:math';
import 'package:geolocator/geolocator.dart';

/// Checks if the point [checkPoint] is in the radius
/// user location [imHere] and conditions specified by it
/// [minDistance] and [maxDistance] in meters.
class DistanceToPlace {
  double check({
    Position checkPoint,
    Position userPoint,
    double minDistance,
    double maxDistance,
  }) {
    const double ky = 40000000 / 360;
    final double kx = cos(pi * checkPoint.latitude / 180.0) * ky;
    final double dx = (checkPoint.longitude - userPoint.longitude).abs() * kx;
    final double dy = (checkPoint.latitude - userPoint.latitude).abs() * ky;
    final double distance = sqrt(dx * dx + dy * dy);
    //return distance >= minDistance && distance <= maxDistance;
    return distance;
  }
}
