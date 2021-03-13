import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_types.dart';
import 'package:places/data/interactor/places.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/utils/filter.dart';

/// Provider for PlacesSearchScreen.
class PlacesSearch with ChangeNotifier {
  /// [_searchHistory] - the history of search queries.
  final List _searchHistory = [];

  /// [_searchFieldController] - controller for search field.
  final TextEditingController _searchFieldController = TextEditingController();

  /// [_searchResults] - search results by type, range and search query.
  final List _searchResults = [];

  /// [_searchRangeStart] - the initial search range.
  int _searchRangeStart = 100;

  /// [_searchRangeEnd] - maximum search range.
  int _searchRangeEnd = 10000;

  /// [_searchFieldIsNotEmpty] - true if the search controller is empty
  bool _searchFieldIsNotEmpty = false;

  /// [_isPlacesNotFound] - if nothing was added to [_searchResults]
  bool _isPlacesNotFound = false;

  /// getters for fields with the same name
  List get searchHistory => _searchHistory;
  List get searchResults => _searchResults;
  int get searchRangeStart => _searchRangeStart;
  int get searchRangeEnd => _searchRangeEnd;
  bool get searchFieldIsNotEmpty => _searchFieldIsNotEmpty;
  bool get isPlacesNotFound => _isPlacesNotFound;
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
    isTapFromHistory = false,
    isSearchFromFilterScreen = false,
  }) {
    searchQuery = searchQuery ?? _searchFieldController.value.text;

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

    searchHandler(searchQuery);

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

  /// [searchHandler] search request handler.
  /// Found locations are added to [_searchResults].
  void searchHandler(String searchQuery) {
    searchQuery = _searchFieldController
        .value.text; // TODO исправить баг с поисковым запросом.
    print(searchQuery);

    if (_searchResults.isNotEmpty) _searchResults.clear();
    _isPlacesNotFound = false;

    /// [_places] - array with places.
    final List _places =
        Places().places; // TODO брать места из провайдера мест Places
    /// [_placeTypesData] - array with place types.
    final List _placeTypesData =
        PlaceTypes().placeTypesData; // TODO брать типы из провайдера PlaceTypes

    /// An array of places types selected in the filter
    final List _selectedTypes = [];

    /// Places found by type and range
    final List _foundPlacesByTypesAndRange = [];

    /// Test user location
    final GeoPosition _testGeoPosition = GeoPosition(0.0, 0.0);

    /// create a list [_selectedTypes] only with
    /// selected categories
    _placeTypesData.forEach(
      (
        placeType,
      ) {
        if (placeType["selected"] == true) {
          _selectedTypes.add(placeType["name"]);
        }
      },
    );

    /// create a list [_foundPlacesBySelectedTypes] with filtered
    /// data from by [_selectedTypes], [_searchRangeStart], [_searchRangeEnd]
    /// and the user's location [_testGeoPosition]
    if (_selectedTypes.isNotEmpty && _places.isNotEmpty) {
      _places.forEach((
        place,
      ) {
        _selectedTypes.forEach(
          (selectedType) {
            // if the place type matches the active categories from the filter
            if (selectedType == place.placeType) {
              bool _isPlaceInsideRange = IsPlaceInsideSearchRange().check(
                imHere: _testGeoPosition,
                checkPoint: place.geoPosition,
                minDistance: _searchRangeStart.toDouble(),
                maxDistance: _searchRangeEnd.toDouble(),
              );

              // if the place is in the search range
              if (_isPlaceInsideRange) _foundPlacesByTypesAndRange.add(place);
            }
          },
        );
      });
    }

    /// Filter [_foundPlacesBySelectedTypes] by
    /// search query, if it is set and create
    /// ready array of found locations [_searchResults].
    if (_foundPlacesByTypesAndRange.isNotEmpty) {
      _foundPlacesByTypesAndRange.forEach(
        (place) {
          if (searchQuery.isNotEmpty) {
            bool _isSearchQueryMatchName =
                place.name.toLowerCase().contains(searchQuery.toLowerCase());
            if (_isSearchQueryMatchName) _searchResults.add(place);
          } else
            _searchResults.add(place);
        },
      );
    }

    /// If no places 1were found for the request.
    if (_searchResults.isEmpty) _isPlacesNotFound = true;
  }
}
