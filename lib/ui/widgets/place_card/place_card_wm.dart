import 'dart:io';

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/place_details_screen/place_details_widget_builder.dart';
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
        (placeDetailsContainer) => _showPlaceDetails());

    subscribe(onAddingToFavoritesAction.stream, (_) => _addToFavorites());

    subscribe(
        onRemoveFromFavoritesAction.stream, (_) => _removeFromFavorites());

    subscribe(onOpenNativeMapAction.stream,
        (_) => placesInteractor.openNativeDeviceMap(place));
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

  /// Action to open native device map
  final onOpenNativeMapAction = Action<void>();

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
  void _showPlaceDetails() {
    /// Ранее мы делали BottomSheet...
    /// для анимации переделываю на обычный роутинг
    // showModalBottomSheet(
    //   context: navigator.context,
    //   builder: (_) {
    //     return placeDetailsContainer;
    //   },
    //   isScrollControlled: true,
    // );
    //

    navigator.push(
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return PlaceDetailsWidget(
            place.id,
            placeImages: place.urls,
          );
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
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
