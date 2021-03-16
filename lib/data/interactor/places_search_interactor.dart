import 'package:flutter/material.dart';
import 'package:places/ui/view_model/place_types_model.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/filtered_places_repository.dart';

/// Provider for PlacesSearchScreen.
class PlacesSearchInteractor with ChangeNotifier {
  /// [_searchHistory] - the history of search queries.
  final List<String> _searchHistory = [];

  /// [_searchResults] - search results by type, range and search query.
  List<Place> _searchResults = [];

  /// getters for fields with the same name
  List<String> get searchHistory => _searchHistory;
  List<Place> get searchResults => _searchResults;

  /// Adding a query to the search history
  void addQuery(String query) {
    _searchHistory.add(query);
    notifyListeners();
  }

  /// Deleting all requests from the search history
  void cleanHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  /// Deleting all search results
  void cleanResults() {
    _searchResults.clear();
    notifyListeners();
  }

  /// Deleting a query from the search history
  void deleteQuery(int index) {
    _searchHistory.removeAt(index);
    notifyListeners();
  }

  /// [searchPlaces] - is a search request handler.
  /// Found locations are added to [_searchResults].
  Future<List<Place>> searchPlaces(String searchQuery, int searchRadius) async {
    if (searchResults.isNotEmpty) searchResults.clear();

    final List placeTypesData =
        PlaceTypes().placeTypesData; // TODO брать типы из провайдера PlaceTypes

    /// An array of places types selected in the filter
    final List selectedTypes = [];

    /// Test user location
    final GeoPosition testGeoPosition = GeoPosition(59.884866, 29.904859);

    /// In [searchResponse] will be the data from the server
    List<Place> searchResponse = [];

    /// create a list [_selectedTypes] only with
    /// selected categories
    placeTypesData.forEach(
      (
        placeType,
      ) {
        if (placeType["selected"] == true) {
          selectedTypes.add(placeType["name"]);
        }
      },
    );

    searchResponse = await FilteredPlaceRepository().searchPlaces(
      searchQuery: searchQuery,
      geoposition: testGeoPosition,
      selectedTypes: selectedTypes,
      searchRadius: searchRadius,
    );

    _searchResults = searchResponse;

    return _searchResults;
  }
}
