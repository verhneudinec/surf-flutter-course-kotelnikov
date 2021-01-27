import 'package:places/domain/geo_position.dart';

class Sight {
  final String name;
  final GeoPosition geoPosition;
  final String url;
  final String details;
  final String type;
  final String workingTime;

  Sight(
    this.name,
    this.geoPosition,
    this.url,
    this.details,
    this.type,
    this.workingTime,
  );
}
