import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api/api_client.dart';
import 'package:places/data/repository/api/api_mapping.dart';
import 'package:places/data/repository/api/api_urls.dart';

/// Repository for getting places data from the server
class PlaceRepository {
  List<Place> _places = [];
  final ApiClient _client = ApiClient();

  List<Place> get places => _places;

  /// Function for getting data from the API.
  /// Returns list of places.
  Future<dynamic> loadPlace() async {
    _client.initInterceptors();
    final response = await _client.dio.get(
      ApiUrls.place,
    );

    List<Place> placeList = List<Place>.from(
      response.data.map(
        (place) => ApiMapping().placeFromJson(place),
      ),
    );

    return placeList;
  }

  /// Function for getting place details from the API
  Future<dynamic> getPlaceDetails({int id}) async {
    _client.initInterceptors();
    final response = await _client.dio.get(
      ApiUrls.place + "/" + id.toString(),
    );

    dynamic place = response.data;

    return ApiMapping().placeFromJson(place);
  }

  /// Function for adding place to the server.
  /// Returns the object received from the server.
  Future<Place> addNewPlace({Place place}) async {
    _client.initInterceptors();
    final request = await _client.dio.post(
      ApiUrls.place,
      data: ApiMapping().placeToJson(place),
    );

    final response = request.data;

    return ApiMapping().placeFromJson(response);
  }
}
