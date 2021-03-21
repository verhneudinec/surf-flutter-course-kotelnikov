import 'package:flutter/material.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/view_model/place_types_model.dart';
import 'package:provider/provider.dart';

/// ViewModel for [PlacesSearchScreen].
class PlacesSearchModel with ChangeNotifier {
  /// [_searchFieldController] - controller for search field.
  final TextEditingController _searchFieldController = TextEditingController();

  /// [_searchRangeStart] - the initial search range.
  int _searchRangeStart = 100;

  /// [_searchRangeEnd] - maximum search range.
  int _searchRangeEnd = 10000;

  /// [_searchFieldIsNotEmpty] - true if the search controller is empty
  bool _searchFieldIsNotEmpty = false;

  /// [_isPlacesNotFound] - if nothing was added to [_searchResults]
  bool _isPlacesNotFound = false;

  /// [_isPlacesLoading] -  true if the request has gone to the server
  /// and the places are being loaded
  bool _isPlacesLoading = false;

  /// getters for fields with the same name
  int get searchRangeStart => _searchRangeStart;
  int get searchRangeEnd => _searchRangeEnd;
  bool get searchFieldIsNotEmpty => _searchFieldIsNotEmpty;
  bool get isPlacesNotFound => _isPlacesNotFound;
  bool get isPlacesLoading => _isPlacesLoading;
  TextEditingController get searchFieldController => _searchFieldController;

  /// [onSearchChanged] called when a change
  /// has been made to the search field
  void onSearchChanged(BuildContext context) {
    _isPlacesNotFound = false;
    context.read<PlacesSearchInteractor>().searchResults.clear();
    _searchFieldIsNotEmpty = _searchFieldController.value.text.isNotEmpty;
    notifyListeners();
  }

  /// [onSearchRangeStartChanged] called when
  /// a change has been made to the initial range
  void onSearchRangeStartChanged(int newValue) {
    _searchRangeStart = newValue;
    notifyListeners();
  }

  /// [onSearchRangeStartChanged] called when
  /// a change has been made to the maximum range
  void onSearchRangeEndChanged(int newValue) {
    _searchRangeEnd = newValue;
    notifyListeners();
  }

  /// [onSearchSubmitted] called when sending a search form.
  /// [isTapFromHistory] - true if sending was made after clicking on an item from the search history.
  /// [isSearchFromFilterScreen] - true if there was a call from the filter screen.
  void onSearchSubmitted({
    @required BuildContext context,
    String searchQuery,
    bool isTapFromHistory = false,
    bool isSearchFromFilterScreen = false,
  }) async {
    searchQuery = searchQuery ?? _searchFieldController.value.text;

    _isPlacesLoading = true;

    if (searchQuery.isNotEmpty && !isSearchFromFilterScreen) {
      _searchFieldIsNotEmpty = true;

      /// Eliminate duplicate additions to the request history
      /// when calling [onSearchSubmitted] from [FilterScreen]
      context.read<PlacesSearchInteractor>().addQuery(searchQuery);
    } else if (isSearchFromFilterScreen == true) {
      _searchFieldIsNotEmpty = true;
    }

    if (isTapFromHistory == true) {
      _searchFieldController.text = searchQuery;
    }

    /// The [_searchResults] variable stores the response
    /// result from the [PlacesSearchInteractor] repository
    List<Place> _searchResults;

    List<Map<String, Object>> placeTypes =
        context.read<PlaceTypesModel>().placeTypesData;

    /// An array of places types selected in the filter
    final List<String> selectedPlaceTypes = [];

    placeTypes.forEach(
      (placeType) {
        if (placeType["selected"] == true) {
          selectedPlaceTypes.add(placeType["name"]);
        }
      },
    );

    _searchResults = await context.read<PlacesSearchInteractor>().searchPlaces(
        searchQuery: searchQuery,
        searchRadius: _searchRangeEnd,
        placeTypes: selectedPlaceTypes);

    /// If no places were found for the request.
    if (_searchResults.isEmpty) _isPlacesNotFound = true;

    _isPlacesLoading = false;

    notifyListeners();
  }

  /// Очистка поисковой строки
  void onClearTextValue() {
    _searchFieldIsNotEmpty = false;
    _searchFieldController.clear();
    notifyListeners();
  }

  /// Deleting a query from the search history
  void onQueryDelete(BuildContext context, int index) {
    context.read<PlacesSearchInteractor>().deleteQuery(index);
  }

  /// Deleting all requests from the search history
  void onCleanHistory(BuildContext context) {
    context.read<PlacesSearchInteractor>().cleanHistory();
  }

  /// Clearing search ranges
  void onCleanRange(BuildContext context) {
    _searchRangeStart = 100;
    _searchRangeEnd = 10000;
    context.read<PlacesSearchInteractor>().cleanResults();
    notifyListeners();
  }
}
