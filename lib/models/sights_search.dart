import 'package:flutter/material.dart';
import 'package:places/models/sight_types.dart';
import 'package:places/models/sights.dart';
import 'package:places/domain/geo_position.dart';
import 'package:places/utils/filter.dart';
import 'package:places/mocks.dart';

/// Provider for SightsSearchScreen.
class SightsSearch with ChangeNotifier {
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

  /// [_isSightsNotFound] - if nothing was added to [_searchResults]
  bool _isSightsNotFound = false;

  /// getters for fields with the same name
  List get searchHistory => _searchHistory;
  List get searchResults => _searchResults;
  int get searchRangeStart => _searchRangeStart;
  int get searchRangeEnd => _searchRangeEnd;
  bool get searchFieldIsNotEmpty => _searchFieldIsNotEmpty;
  bool get isSightsNotFound => _isSightsNotFound;
  TextEditingController get searchFieldController => _searchFieldController;

  /// [onSearchChanged] called when a change
  /// has been made to the search field
  void onSearchChanged() {
    _isSightsNotFound = false;
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
    _isSightsNotFound = false;

    /// [_sights] - array with places.
    final List _sights =
        Sights().sights; // TODO брать места из провайдера мест Sights
    /// [_sightTypesData] - array with sight types.
    final List _sightTypesData =
        SightTypes().sightTypesData; // TODO брать типы из провайдера SightTypes

    /// An array of places types selected in the filter
    final List _selectedTypes = [];

    /// Places found by type and range
    final List _foundSightsByTypesAndRange = [];

    /// Test user location
    final GeoPosition _testGeoPosition = testGeoPosition;

    /// create a list [_selectedTypes] only with
    /// selected categories
    _sightTypesData.forEach(
      (
        sightType,
      ) {
        if (sightType["selected"] == true) {
          _selectedTypes.add(sightType["name"]);
        }
      },
    );

    /// create a list [_foundSightsBySelectedTypes] with filtered
    /// data from by [_selectedTypes], [_searchRangeStart], [_searchRangeEnd]
    /// and the user's location [_testGeoPosition]
    if (_selectedTypes.isNotEmpty && _sights.isNotEmpty) {
      _sights.forEach((
        sight,
      ) {
        _selectedTypes.forEach(
          (selectedType) {
            // if the sight type matches the active categories from the filter
            if (selectedType == sight.type) {
              bool _isSightInsideRange = IsSightInsideSearchRange().check(
                imHere: _testGeoPosition,
                checkPoint: sight.geoPosition,
                minDistance: _searchRangeStart.toDouble(),
                maxDistance: _searchRangeEnd.toDouble(),
              );

              // if the sight is in the search range
              if (_isSightInsideRange) _foundSightsByTypesAndRange.add(sight);
            }
          },
        );
      });
    }

    /// Filter [_foundSightsBySelectedTypes] by
    /// search query, if it is set and create
    /// ready array of found locations [_searchResults].
    if (_foundSightsByTypesAndRange.isNotEmpty) {
      _foundSightsByTypesAndRange.forEach(
        (sight) {
          if (searchQuery.isNotEmpty) {
            bool _isSearchQueryMatchName =
                sight.name.toLowerCase().contains(searchQuery.toLowerCase());
            if (_isSearchQueryMatchName) _searchResults.add(sight);
          } else
            _searchResults.add(sight);
        },
      );
    }

    /// If no sights 1were found for the request.
    if (_searchResults.isEmpty) _isSightsNotFound = true;
  }
}
