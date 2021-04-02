import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:relation/relation.dart';

/// Widget model of place details screen
class PlaceDetailsWidgetModel extends WidgetModel {
  final PlacesInteractor placesInteractor;
  final NavigatorState navigator;

  final int placeId;
  final bool isBottomSheet;

  PageController photogalleryController = PageController();

  /// Place details
  EntityStreamedState<Place> placeState = EntityStreamedState(
    EntityState.loading(),
  );

  /// Current page in the gallery
  EntityStreamedState<int> photogalleryPageIndex = EntityStreamedState(
    EntityState.content(0),
  );

  /// `true` if the place is in the favorites
  EntityStreamedState<bool> isPlaceInFavorites = EntityStreamedState();

  PlaceDetailsWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.placesInteractor,
    this.navigator, {
    this.placeId,
    this.isBottomSheet,
  }) : super(baseDependencies);

  ///         ///
  ///    WM   ///
  ///         ///

  @override
  void onLoad() {
    _getPlaceDetails();

    isPlaceInFavorites.content(
      placesInteractor.isPlaceInFavorites(placeState.value.data),
    );

    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(onPhotogalleryPageUpdateAction.stream, (value) {
      photogalleryPageIndex.content(value);
    });

    subscribe(onRemoveFromFavoritesAction.stream, (_) {
      placesInteractor.removeFromFavorites(placeState.value.data);
      isPlaceInFavorites.content(false);
    });

    subscribe(onAddingToFavoritesAction.stream, (_) {
      placesInteractor.addToFavorites(placeState.value.data);
      isPlaceInFavorites.content(true);
    });

    subscribe(
      getPlaceDetailsAction.stream,
      (_) => _getPlaceDetails(),
    );
  }

  ///         ///
  /// Actions ///
  ///         ///

  /// Get complete information about the place
  Action<void> getPlaceDetailsAction = Action();

  /// Action to update the index of the current photo in gallery
  Action<void> onPhotogalleryPageUpdateAction = Action();

  /// Add a place to favorites
  Action<void> onAddingToFavoritesAction = Action();

  /// Remove a place from favorites
  Action<void> onRemoveFromFavoritesAction = Action();

  ///            ///
  /// Functions  ///
  ///            ///

  /// Function for getting full information about a place from [PlacesInteractor]
  void _getPlaceDetails() async {
    final Place loadedPlace =
        await placesInteractor.loadPlaceDetails(id: placeId);
    placeState.content(loadedPlace);
  }
}
