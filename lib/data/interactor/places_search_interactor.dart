import 'package:flutter/material.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/filtered_places_repository.dart';
import 'package:places/data/repository/storage/app_preferences.dart';

/// Provider for PlacesSearchScreen.
class PlacesSearchInteractor with ChangeNotifier {
  /// [_searchResults] - search results by type, range and search query.
  List<Place> _searchResults = [];

  /// The last query entered by the user
  String _lastSearchQuery = '';

  /// Filter by type of location and radius
  Filter _filter = Filter.empty();

  AppPreferences _appPreferences;

  ///         ///
  /// Getters ///
  ///         ///

  List<Place> get searchResults => _searchResults;
  String get lastSearchQuery => _lastSearchQuery;
  Filter get filter => _filter;
  List<String> get selectedPlaceTypes => filter.searchTypes.keys
      .where((element) => filter.searchTypes[element])
      .toList();

  ///         ///
  /// Setters ///
  ///         ///

  /// TODO Переделать в сеттер
  void setAppPreferences(AppPreferences appPrefs) => _appPreferences = appPrefs;

  ///           ///
  /// Functions ///
  ///           ///

  /// Function for initializing the filter from storage
  Future<void> initFilter() async {
    // Get the ending search radius from storage
    final int filterSearchRangeEnd = await _appPreferences.searchRadius;

    _filter.searchRange.end =
        filterSearchRangeEnd == 0 ? 10000 : filterSearchRangeEnd;

    // Get the selected filter types from storage
    final List<String> filterTypes = await _appPreferences.searchTypes;

    filterTypes.forEach(
      (type) {
        if (_filter.searchTypes.keys.contains(type))
          _filter.searchTypes[type] = true;
      },
    );
  }

  /// Function for setting the filter
  void filterSubmit(Filter filter) async {
    _filter = filter;

    // Save the obtained values ​​to the storage
    _appPreferences.setSearchRadius(filter.searchRange.end);
    _appPreferences.setSearchTypes(selectedPlaceTypes);
  }

  /// [searchPlaces] - is a search request handler.
  /// Found locations are added to [_searchResults].
  Future<List<Place>> searchPlaces({
    String searchQuery,
  }) async {
    _lastSearchQuery = searchQuery ?? _lastSearchQuery;

    searchResults.clear();

    /// Test user location
    final GeoPosition testGeoPosition = GeoPosition(59.884866, 29.904859);

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
