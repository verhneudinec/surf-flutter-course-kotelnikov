import 'package:places/domain/geo_position.dart';

/// Template for creating instances of places.
/// [name] - place name.
/// [geoPosition] - an instance of the [GeoPosition] class.
/// [url] - a picture of the place.
/// [details] - description.
/// [type] - place type, category.
/// [workingTime] - working hours.
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
