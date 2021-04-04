import 'package:places/data/model/geo_position.dart';
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
    GeoPosition geoposition,
    List<String> selectedTypes,
    int searchRadius,
  }) async {
    try {
      _client.initInterceptors();
      final response = await _client.dio.post(
        ApiUrls.filteredPlaces,
        data: {
          // пока что реализован поиск только по имени (вроде по заданию так).
          // хотя все данные из контроллеров и приходят,
          // но запросы еще не тестировались + нет обработки ошибок.
          "nameFilter": searchQuery,
          // "lat": geoposition.lat,
          // "lng": geoposition.lng,
          // "radius": searchRadius,
          // "typeFilter": selectedTypes,
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
