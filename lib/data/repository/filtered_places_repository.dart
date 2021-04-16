import 'package:geolocator/geolocator.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api/api_client.dart';
import 'package:places/data/repository/api/api_mapping.dart';
import 'package:places/data/repository/api/api_urls.dart';

/// Repository for getting filtered places from the server
class FilteredPlaceRepository {
  List<Place> _places = [];
  final ApiClient _client = ApiClient();

  List<Place> get places => _places;

  /// Function for getting filtered data from the API.
  /// Returns list of places.
  Future<List> searchPlaces({
    String searchQuery,
    Position geoposition,
    List<String> selectedTypes,
    int searchRadius,
  }) async {
    try {
      _client.initInterceptors();
      final response = await _client.dio.post(
        ApiUrls.filteredPlaces,
        data: {
          "nameFilter": searchQuery,
          "lat": geoposition.latitude,
          "lng": geoposition.longitude,
          "radius": searchRadius +
              0.1, // TODO Сервер не ищет, если после точки указан 0. Думаю нужно бэк поправить
        },
      );

      List<Place> placeList = [];

      // TODO Вынести в отдельную сущность
      if (response.statusCode == 200)
        placeList = List<Place>.from(
          response.data.map(
            (place) => ApiMapping().placeFromJson(place),
          ),
        );

      return placeList;
    } catch (e) {
      _client.exceptionHandler(e);
      return [];
    }
  }
}
