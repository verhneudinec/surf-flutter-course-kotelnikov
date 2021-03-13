import 'package:places/data/model/geo_position.dart';

/// This is a place data model.
/// [id] - id of the place int the database.
/// [lat] - latitude, [lon] - longitude.
/// [name] - place name.
/// [urls] - links to photos of the place.
/// [placeType] - place type, category.
/// [description] - place description.
class Place {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;
  //final bool isVisited;

  Place({
    this.id,
    this.lat,
    this.lng,
    this.name,
    this.urls,
    this.placeType,
    this.description,
  });
}
