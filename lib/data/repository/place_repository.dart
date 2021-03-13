import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api/api_client.dart';
import 'package:places/data/repository/api/api_urls.dart';

class PlaceRepository {
  List<Place> _places = [];
  final ApiClient _client = ApiClient();

  List<Place> get places => _places;

  /// Function for getting data from the API
  Future<dynamic> loadPlace() async {
    _client.initInterceptors();
    final response = await _client.dio.get(
      ApiUrls.place,
    );

    List<Place> placeList = List<Place>.from(
      response.data.map(
        (place) => Place(
          id: place['id'],
          description: place['description'] ?? "Не указано",
          lat: place['lat'] ?? 0,
          lng: place['lon'] ?? 0,
          name: place['name'] ?? "Не указано",
          placeType: place['placeType'] ?? "Не указано",
          urls: List<String>.from(place['urls']),
        ),
      ),
    );

    return placeList;
  }
}
