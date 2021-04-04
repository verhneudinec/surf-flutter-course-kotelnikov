import 'package:flutter/material.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/filtered_places_repository.dart';

/// Provider for PlacesSearchScreen.
class PlacesSearchInteractor with ChangeNotifier {
  /// [_searchResults] - search results by type, range and search query.
  List<Place> _searchResults = [];

  /// The last query entered by the user
  String _lastSearchQuery = '';

  /// Filter by type of location and radius
  Filter _filter = Filter.empty();

  ///         ///
  /// Getters ///
  ///         ///

  List<Place> get searchResults => _searchResults;
  String get lastSearchQuery => _lastSearchQuery;
  Filter get filter => _filter;

  ///           ///
  /// Functions ///
  ///           ///

  /// Function for setting the filter
  void filterSubmit(Filter filter) => _filter = filter;

  /// [searchPlaces] - is a search request handler.
  /// Found locations are added to [_searchResults].
  Future<List<Place>> searchPlaces({
    String searchQuery,
  }) async {
    _lastSearchQuery = searchQuery ?? _lastSearchQuery;

    searchResults.clear();

    /// Test user location
    final GeoPosition testGeoPosition = GeoPosition(59.884866, 29.904859);

    final List<String> selectedPlaceTypes = filter.searchTypes.keys
        .where((element) => filter.searchTypes[element])
        .toList();

    /// In [searchResponse] will be the data from the server
    List<Place> searchResponse = await FilteredPlaceRepository().searchPlaces(
      searchQuery: searchQuery ?? lastSearchQuery,
      geoposition: testGeoPosition,
      selectedTypes: selectedPlaceTypes,
      searchRadius: filter.searchRange.end,
    );

    _searchResults = searchResponse;

    return _searchResults;
  }
}
