import 'package:flutter/material.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/filtered_places_repository.dart';
import 'package:places/data/repository/storage/app_preferences.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

/// Provider for PlacesSearchScreen.
class PlacesSearchInteractor with ChangeNotifier {
  /// [_searchResults] - search results by type, range and search query.
  List<Place> _searchResults = [];

  AppDB _db;

  EntityStreamedState<List<String>> _searchHistory =
      EntityStreamedState<List<String>>(
    EntityState.content([]),
  );

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
  EntityStreamedState<List<String>> get searchHistory => _searchHistory;
  List<String> get selectedPlaceTypes => filter.searchTypes.keys
      .where((element) => filter.searchTypes[element])
      .toList();

  ///           ///
  /// Functions ///
  ///           ///

  /// Function for initializing the filter from storage
  Future<void> initFilter() async {
    // Get the ending search radius from storage
    final int filterSearchRangeEnd = await AppPreferences.searchRadius;

    _filter.searchRange.end =
        filterSearchRangeEnd == 0 ? 10000 : filterSearchRangeEnd;

    // Get the selected filter types from storage
    final List<String> filterTypes = await AppPreferences.searchTypes;

    filterTypes.forEach(
      (type) {
        if (_filter.searchTypes.keys.contains(type))
          _filter.searchTypes[type] = true;
      },
    );
  }

  void initSearchHistoryTable(BuildContext context) {
    _db = context.read<AppDB>();

    _db.searchHistorysDao.searchHistory
        .then((value) => _searchHistory.content(value));
  }

  void addQueryToHistory(String searchQuery) {
    _db.searchHistorysDao.saveSearchQuery(
      searchQuery,
    );

    _searchHistory.content(
      _searchHistory.value.data..add(searchQuery),
    );
  }

  void deleteQueryFromHistory(String query) async {
    await _db.searchHistorysDao.deleteSearchQuery(query);
    _searchHistory.content(_searchHistory.value.data..remove(query));
  }

  void clearSearchHistory() async {
    await _db.searchHistorysDao.clearSearchHistory();
    _searchHistory.content([]);
  }

  /// Function for setting the filter
  void filterSubmit(Filter filter) async {
    _filter = filter;

    // Save the obtained values ​​to the storage
    AppPreferences.setSearchRadius(filter.searchRange.end);
    AppPreferences.setSearchTypes(selectedPlaceTypes);
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
