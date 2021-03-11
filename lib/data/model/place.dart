import 'package:places/data/model/geo_position.dart';

/// Template for creating instances of places.
/// [name] - place name.
/// [geoPosition] - an instance of the [GeoPosition] class.
/// [url] - a picture of the place.
/// [details] - description.
/// [type] - place type, category.
/// [workingTime] - working hours.
class Place {
  final String name;
  final GeoPosition geoPosition;
  final List<String> urls;
  final String details;
  final String type;
  final String workingTime;
  final bool isVisited;

  Place(
    this.name,
    this.geoPosition,
    this.urls,
    this.details,
    this.type,
    this.workingTime,
    this.isVisited,
  );
}
