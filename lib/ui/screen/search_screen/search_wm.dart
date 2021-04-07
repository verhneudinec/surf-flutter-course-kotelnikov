import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/place_details_screen/place_details_route.dart';
import 'package:relation/relation.dart';

/// Widget model of search screen
class SearchWidgetModel extends WidgetModel {
  final PlacesSearchInteractor searchInteractor;
  final NavigatorState navigator;

  /// [_searchFieldController] - controller for search field.
  final TextEditingAction searchFieldAction = TextEditingAction();

  /// Searching results
  EntityStreamedState<List<Place>> searchResults = EntityStreamedState(
    EntityState.content([]),
  );

  /// Search history state
  EntityStreamedState<List<String>> searchHistory = EntityStreamedState(
    EntityState.content([]),
  );

  SearchWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.searchInteractor,
    this.navigator,
  ) : super(baseDependencies);

  ///         ///
  ///    WM   ///
  ///         ///

  @override
  void onLoad() {
    searchInteractor.initFilter();
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(onSearchChangedAction.stream, (_) {
      searchResults.content([]);
    });

    subscribe(
      onClearTextValueAction.stream,
      (_) => searchFieldAction.controller.clear(),
    );

    subscribe(
      onClearHistoryAction.stream,
      (_) => searchHistory.content([]),
    );

    subscribe(
      onPlaceClickAction.stream,
      (index) => navigator.push(
        PlaceDetailsRoute(searchResults.value.data[index].id),
      ),
    );

    subscribe(
      onQueryDeleteAction.stream,
      (index) => searchHistory.content(
        searchHistory.value.data..removeAt(index),
      ),
    );
  }

  ///         ///
  /// Actions ///
  ///         ///

  /// When changing the search string
  Action<void> onSearchChangedAction = Action();

  /// Action to clear the search string
  Action<void> onClearTextValueAction = Action();

  /// Clear search history
  Action<void> onClearHistoryAction = Action();

  /// When clicking on a place
  Action<void> onPlaceClickAction = Action();

  /// Deleting a query from the search history
  Action<void> onQueryDeleteAction = Action();

  ///            ///
  /// Functions  ///
  ///            ///

  /// [onSearchSubmitted] called when sending a search form.
  /// [isTapFromHistory] - true if sending was made after clicking on an item from the search history.
  /// [isSearchFromFilterScreen] - true if there was a call from the filter screen.
  void onSearchSubmitted({
    String searchQuery,
    bool isTapFromHistory = false,
  }) async {
    searchResults.loading();

    searchQuery = searchQuery ?? searchFieldAction.controller.text;

    if (isTapFromHistory) searchFieldAction.controller.text = searchQuery;

    if (searchQuery.isNotEmpty) {
      searchHistory.content(
        searchHistory.stateSubject.value.data..add(searchQuery),
      );
    }

    /// The [searchResponse] variable stores the response
    /// result from the [searchInteractor]
    final List<Place> searchResponse =
        await searchInteractor.searchPlaces(searchQuery: searchQuery);

    searchResults.content(searchResponse);

    /// If no places were found for the request.
    if (searchResponse.isEmpty) searchResults.error();
  }
}
