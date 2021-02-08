import 'package:flutter/material.dart';
import 'package:places/res/localization.dart';
import 'package:provider/provider.dart';
import 'package:places/models/sight_types.dart';
import 'package:places/models/sights.dart';
import 'package:places/domain/geo_position.dart';
import 'package:places/utils/filter.dart';
import 'package:places/mocks.dart';

/// Provider for place types.
class SightsSearch with ChangeNotifier {
  final List _searchHistory = [];
  final TextEditingController _searchFieldController = TextEditingController();
  final List _searchResults = [];
  int _searchRangeStart = 100;
  int _searchRangeEnd = 10000;
  bool _searchFieldIsNotEmpty = false;
  bool _isSightsNotFound = false;

  List get searchHistory => _searchHistory;
  List get searchResults => _searchResults;
  int get searchRangeStart => _searchRangeStart;
  int get searchRangeEnd => _searchRangeEnd;
  bool get searchFieldIsNotEmpty => _searchFieldIsNotEmpty;
  bool get isSightsNotFound => _isSightsNotFound;
  TextEditingController get searchFieldController => _searchFieldController;

  void onSearchChanged() {
    _isSightsNotFound = false;
    _searchResults.clear();
    _searchFieldIsNotEmpty = _searchFieldController.value.text.isNotEmpty;
    print(_searchFieldIsNotEmpty);
    notifyListeners();
  }

  void onSearchSubmitted(
    String searchQuery,
  ) {
    _searchFieldIsNotEmpty = true;
    _searchHistory.add(searchQuery);
    searchHandler(searchQuery);
    notifyListeners();
  }

  void onClearTextValue() {
    _searchFieldController.clear();
    notifyListeners();
  }

  void onQueryDelete(int index) {
    _searchHistory.removeAt(index);
    notifyListeners();
  }

  void onCleanHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  void searchHandler(String searchQuery) {
    if (_searchResults.isNotEmpty) _searchResults.clear();
    _isSightsNotFound = false;

    final List _sights = Sights().sights;
    final List _sightTypesData = SightTypes().sightTypesData;
    final List _selectedTypes = [];

    final List _foundSightsByTypesAndRange = [];

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
            if (selectedType == sight.type) {
              bool _isSightInsideRange = IsSightInsideSearchRange().check(
                imHere: _testGeoPosition,
                checkPoint: sight.geoPosition,
                minDistance: _searchRangeStart.toDouble(),
                maxDistance: _searchRangeEnd.toDouble(),
              );

              if (_isSightInsideRange) _foundSightsByTypesAndRange.add(sight);
            }
          },
        );
      });
    }

    /// finally create the [_foundSights] list, filtered taking into
    /// account the selected categories [_selectedTypes], search range
    /// [_searchRangeStart], [_searchRangeEnd] and the user's location
    /// [_testGeoPosition]

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

    if (_searchResults.isEmpty) _isSightsNotFound = true;
  }
}
