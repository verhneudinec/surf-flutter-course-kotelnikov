import 'package:flutter/material.dart';
import 'package:places/ui/view_model/place_types_model.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/filtered_places_repository.dart';

/// Provider for PlacesSearchScreen.
class PlacesSearchInteractor with ChangeNotifier {
  /// [_searchHistory] - the history of search queries.
  final List<String> _searchHistory = [];

  /// [_searchFieldController] - controller for search field.
  final TextEditingController _searchFieldController = TextEditingController();

  /// [_searchResults] - search results by type, range and search query.
  List<Place> _searchResults = [];

  /// [_searchRangeStart] - the initial search range.
  int _searchRangeStart = 100;

  /// [_searchRangeEnd] - maximum search range.
  int _searchRangeEnd = 10000;

  /// [_searchFieldIsNotEmpty] - true if the search controller is empty
  bool _searchFieldIsNotEmpty = false;

  /// [_isPlacesNotFound] - if nothing was added to [_searchResults]
  bool _isPlacesNotFound = false;

  /// [_isPlacesLoading] - if places are loaded from the server
  bool _isPlacesLoading = false;

  /// getters for fields with the same name
  List<String> get searchHistory => _searchHistory;
  List<Place> get searchResults => _searchResults;
  int get searchRangeStart => _searchRangeStart;
  int get searchRangeEnd => _searchRangeEnd;
  bool get searchFieldIsNotEmpty => _searchFieldIsNotEmpty;
  bool get isPlacesNotFound => _isPlacesNotFound;
  bool get isPlacesLoading => _isPlacesLoading;
  TextEditingController get searchFieldController => _searchFieldController;

  /// [onSearchChanged] called when a change
  /// has been made to the search field
  void onSearchChanged() {
    _isPlacesNotFound = false;
    _searchResults.clear();
    _searchFieldIsNotEmpty = _searchFieldController.value.text.isNotEmpty;
    notifyListeners();
  }

  /// [onSearchRangeStartChanged] called when
  /// a change has been made to the initial range
  void onSearchRangeStartChanged(newValue) {
    _searchRangeStart = newValue;
    notifyListeners();
  }

  /// [onSearchRangeStartChanged] called when
  /// a change has been made to the maximum range
  void onSearchRangeEndChanged(newValue) {
    _searchRangeEnd = newValue;
    notifyListeners();
  }

  /// [onSearchSubmitted] called when sending a search form.
  /// [isTapFromHistory] - true if sending was made after clicking on an item from the search history.
  /// [isSearchFromFilterScreen] - true if there was a call from the filter screen.
  void onSearchSubmitted({
    String searchQuery,
    bool isTapFromHistory = false,
    bool isSearchFromFilterScreen = false,
  }) {
    searchQuery = searchQuery ?? _searchFieldController.value.text;

    _isPlacesLoading = true;

    if (searchQuery.isNotEmpty && !isSearchFromFilterScreen) {
      _searchFieldIsNotEmpty = true;

      /// Eliminate duplicate additions to the request history
      /// when calling [onSearchSubmitted] from [FilterScreen]
      _searchHistory.add(searchQuery);
    } else if (isSearchFromFilterScreen == true) {
      _searchFieldIsNotEmpty = true;
    }

    if (isTapFromHistory == true) {
      _searchFieldController.text = searchQuery;
    }

    searchPlaces(searchQuery);

    notifyListeners();
  }

  /// Очистка поисковой строки
  void onClearTextValue() {
    _searchFieldIsNotEmpty = false;
    _searchFieldController.clear();
    notifyListeners();
  }

  /// Deleting a query from the search history
  void onQueryDelete(int index) {
    _searchHistory.removeAt(index);
    notifyListeners();
  }

  /// Deleting all requests from the search history
  void onCleanHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  /// Clearing search ranges
  void onCleanRange() {
    _searchRangeStart = 100;
    _searchRangeEnd = 10000;
    _searchResults.clear();
    notifyListeners();
  }

  /// [searchPlaces] - is a search request handler.
  /// Found locations are added to [_searchResults].
  void searchPlaces(String searchQuery) async {
    searchQuery = searchFieldController.value.text;

    if (searchResults.isNotEmpty) searchResults.clear();
    _isPlacesNotFound = false;

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
      searchRadius: searchRangeEnd,
    );

    _searchResults = searchResponse;

    /// If no places were found for the request.
    if (_searchResults.isEmpty) _isPlacesNotFound = true;

    _isPlacesLoading = false;

    notifyListeners();
  }
}
