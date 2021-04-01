import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/data/model/filter.dart';
import 'package:relation/relation.dart';

/// Widget model of favorite places screen
class FilterWidgetModel extends WidgetModel {
  final PlacesSearchInteractor searchInteractor;
  final NavigatorState navigator;

  /// Filter state
  EntityStreamedState<Filter> filter = EntityStreamedState(
    EntityState.content(Filter.empty()),
  );

  FilterWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.searchInteractor,
    this.navigator,
  ) : super(baseDependencies);

  ///         ///
  /// Binding ///
  ///         ///

  @override
  void onBind() {
    super.onBind();

    subscribe(onFilterSubmittedAction.stream, (_) {
      searchInteractor.filterSubmit(filter.value.data);
      navigator.pop();
    });
  }

  ///         ///
  /// Actions ///
  ///         ///

  Action<void> onFilterSubmittedAction = Action();

  ///           ///
  /// Functions ///
  ///           ///

  /// [onSearchRangeStartChanged] called when
  /// a change has been made to the initial range
  void onSearchRangeStartChanged(int newValue) {
    filter.value.data.searchRange.start = newValue;
    filter.content(filter.value.data);
  }

  /// [onSearchRangeStartChanged] called when
  /// a change has been made to the maximum range
  void onSearchRangeEndChanged(int newValue) {
    filter.value.data.searchRange.end = newValue;
    filter.content(filter.value.data);
  }

  /// Function to clear all active (selected) types
  void onCleanAllSelectedTypes() {
    filter.value.data.searchTypes.entries.forEach(
      (value) => filter.value.data.searchTypes[value.key] = false,
    );

    filter.content(filter.value.data);
  }

  /// The function is called when clicking on a place type.
  /// Inverts the value of the selected type (by index)
  void onTypeClickHandler(int index) {
    final MapEntry<String, bool> currentType =
        filter.value.data.searchTypes.entries.elementAt(index);

    filter.value.data.searchTypes[currentType.key] = !currentType.value;

    filter.content(filter.value.data);
  }
}
