import 'package:places/data/model/place.dart';

class ApiMapping {
  Place placeFromJson(dynamic placeFromJson) {
    return Place(
      id: placeFromJson['id'] as int,
      description: placeFromJson['description'] as String,
      lat: placeFromJson['lat'] as double,
      lng: placeFromJson['lng'] as double,
      name: placeFromJson['name'] as String,
      placeType: placeFromJson['placeType'] as String,
      urls: List<String>.from(placeFromJson['urls']),
      isVisited: false,
    );
  }

  Map<String, Object> placeToJson(Place place) {
    return {
      "lat": place.lat,
      "lng": place.lng,
      "name": place.name,
      "urls": place.urls,
      "placeType": "temple",
      "description": place.description,
    };
  }
}
