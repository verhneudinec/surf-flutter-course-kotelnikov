import 'dart:math';
import 'package:places/domain/geo_position.dart';

/// Checks if the point [checkPoint] is in the radius
/// user location [imHere] and conditions specified by it
/// [minDistance] and [maxDistance] in meters.
bool isPointInsideRange({
  GeoPosition checkPoint,
  GeoPosition imHere,
  double minDistance,
  double maxDistance,
}) {
  const double ky = 40000000 / 360;
  final double kx = cos(pi * checkPoint.lat / 180.0) * ky;
  final double dx = (checkPoint.lon - imHere.lon).abs() * kx;
  final double dy = (checkPoint.lat - imHere.lat).abs() * ky;
  final double distance = sqrt(dx * dx + dy * dy);
  return distance >= minDistance && distance <= maxDistance;
}
