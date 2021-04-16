import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api/api_client.dart';
import 'package:places/data/repository/api/api_mapping.dart';
import 'package:places/data/repository/api/api_urls.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

/// Repository for getting places data from the server
class PlaceRepository {
  List<Place> _places = [];
  final ApiClient _client = ApiClient();

  List<Place> get places => _places;

  /// Function for getting data from the API.
  /// Returns list of places.
  Future<List<Place>> loadPlaces() async {
    try {
      final Response response = await _client.get(ApiUrls.place);

      _places = List<Place>.from(
        response.data.map(
          (place) => ApiMapping().placeFromJson(place),
        ),
      );

      return _places;
    } catch (e) {
      _client.exceptionHandler(e);
      throw e;
    }
  }

  /// Function for getting place details from the API
  Future<Place> getPlaceDetails({@required int id}) async {
    try {
      final Response response = await _client.get(
        ApiUrls.place + "/" + id.toString(),
      );

      Object place = response.data;

      return ApiMapping().placeFromJson(place);
    } catch (e) {
      _client.exceptionHandler(e);
      throw e;
    }
  }

  /// Function for adding place to the server.
  /// Returns the object received from the server.
  Future<Place> addNewPlace({@required Place place}) async {
    try {
      final Response request = await _client.post(
        ApiUrls.place,
        data: ApiMapping().placeToJson(place),
      );

      final Response response = request.data;

      return ApiMapping().placeFromJson(response);
    } catch (e) {
      _client.exceptionHandler(e);
      print(e);
    }
  }

  /// Method for uploading [photo] to the server.
  /// Returns the full url of the image.
  Future<String> uploadPhoto(File photo) async {
    final String mimeType = mime(photo.path);
    final String mimee = mimeType.split('/')[0];
    final String type = mimeType.split('/')[1];

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        photo.path,
        contentType: MediaType(mimee, type),
      ),
    });

    final response = await _client.post(
      ApiUrls.uploadFile,
      data: formData,
    );

    final String apiUrl = _client.dio.options.baseUrl + '/';
    final String photoLocation = response.headers['location'].elementAt(0);

    return apiUrl + photoLocation;
  }
}
