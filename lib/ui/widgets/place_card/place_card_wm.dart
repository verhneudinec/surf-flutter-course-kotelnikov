import 'dart:io';

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/widgets/date_pickers.dart';
import 'package:relation/relation.dart';

/// The place card widget model.
class PlaceCardWidgetModel extends WidgetModel {
  final Place place;
  final String cardType;
  final Action<void> onDeleteFromFavoritesAction;
  final PlacesInteractor placesInteractor;
  final NavigatorState navigator;

  // Is there a place in favorites
  final StreamedState<bool> isPlaceinFavoritesState =
      StreamedState<bool>(false);

  // The selected date in the DatePicker
  DateTime scheduledDate;

  PlaceCardWidgetModel(
    WidgetModelDependencies baseDependencies, {
    this.placesInteractor,
    this.navigator,
    this.place,
    this.cardType,
    this.onDeleteFromFavoritesAction,
  }) : super(baseDependencies);

  ///
  /// WM
  ///

  @override
  void onBind() {
    super.onBind();

    subscribe(onChangeVisitTimeAction.stream, (_) {
      _changeVisitTime();
    });

    subscribe(onPlaceClickAction.stream,
        (placeDetailsContainer) => _showPlaceDetails(placeDetailsContainer));

    subscribe(onAddingToFavoritesAction.stream, (_) => _addToFavorites());

    subscribe(onRemoveFromFavoritesAction.stream,
        (placeDetailsContainer) => _removeFromFavorites());
  }

  @override
  void dispose() {
    isPlaceinFavoritesState.dispose();
    onPlaceClickAction.dispose();
    onChangeVisitTimeAction.dispose();
    super.dispose();
  }

  ///
  /// Actions
  ///

  /// Action for opening place details
  final onPlaceClickAction = Action<void>();

  /// Action to call a modal window with changing the visit time
  final onChangeVisitTimeAction = Action<void>();

  /// Action to add item to favorites
  final onAddingToFavoritesAction = Action<void>();

  /// Action for remove item from favorites
  final onRemoveFromFavoritesAction = Action<void>();

  ///
  /// Functions
  ///

  /// Removes the list item from [PlacesInteractor]
  void _removeFromFavorites() {
    isPlaceinFavoritesState.stateSubject.sink.add(false);
    placesInteractor.removeFromFavorites(place);
    onDeleteFromFavoritesAction(place);
  }

  /// Adding the list item to [PlacesInteractor] provider
  void _addToFavorites() {
    isPlaceinFavoritesState.stateSubject.sink.add(true);
    placesInteractor.addToFavorites(place);
  }

  /// Open a window with details of the place,
  /// if there was a click on the card
  void _showPlaceDetails(Widget placeDetailsContainer) {
    showModalBottomSheet(
      context: navigator.context,
      builder: (_) {
        return placeDetailsContainer;
      },
      isScrollControlled: true,
    );
  }

  /// Сalls a modal window to change the visit time
  void _changeVisitTime() async {
    DateTime res;

    res = await showPlatformDatePicker(
      navigator.context,
      isIos: Platform.isIOS,
    );

    if (res != null) scheduledDate = res;
  }
}
