import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/model/filter.dart';
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

  final _searchHistory = EntityStreamedState<List<String>>(
    EntityState.content([]),
  );

  /// The last query entered by the user
  String _lastSearchQuery = '';

  /// Filter by type of location and radius
  Filter _filter = Filter.empty();

  /// App shared preferences. Initialized in [InitAppInteractor]
  AppPreferences _appPreferences;

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

  void initSearchHistoryTable(BuildContext context) {
    _db = context.read<AppDB>();

    _db.searchHistorysDao.searchHistory
        .then((value) => _searchHistory.content(value));
  }

  void addQueryToHistory(String searchQuery) {
    // Double check. If the request is in the database, then do nothing.
    if (!_searchHistory.value.data.contains(searchQuery)) {
      _db.searchHistorysDao.saveSearchQuery(
        searchQuery,
      );

      _searchHistory.content(
        _searchHistory.value.data..add(searchQuery),
      );
    }
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

    final Position userGeoposition = await getUserPosition();

    /// In [searchResponse] will be the data from the server
    List<Place> searchResponse = await FilteredPlaceRepository().searchPlaces(
      searchQuery: searchQuery ?? lastSearchQuery,
      geoposition: userGeoposition,
      selectedTypes: selectedPlaceTypes,
      searchRadius: filter.searchRange.end,
    );

    _searchResults = searchResponse;

    return _searchResults;
  }

  /// Function for getting the user's geolocation
  Future<Position> getUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    /// Testing permissions
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    /// All permissions have been granted, now we can use the user's location
    final Position userPosition = await Geolocator.getCurrentPosition();

    return userPosition;
  }
}
