import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:relation/relation.dart';

/// Widget model of favorite places screen
class FavoritesWidgetModel extends WidgetModel {
  final PlacesInteractor placesInteractor;
  final NavigatorState navigator;

  // Used to manage tabs
  final tabController = EntityStreamedState<TabController>();

  /// List of favorite places from [PlacesInteractor]
  EntityStreamedState<List<Place>> get favoritePlaces =>
      placesInteractor.favoritePlaces;

  /// List of places from favorites with parameter [isVisited] = true.
  EntityStreamedState<List<Place>> get visitedPlaces =>
      placesInteractor.visitedPlaces;

  FavoritesWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.placesInteractor,
    this.navigator,
  ) : super(baseDependencies);

  ///
  /// WM
  ///

  @override
  void onLoad() {
    super.onLoad();

    _initFavorites();

    visitedPlaces.content(placesInteractor.visitedPlaces.value.data);
  }

  Future<void> _initFavorites() async {
    // final List<Place> favoritesPlaces =
    //     await placesInteractor.getFavoritePlaces;
    // favoritePlaces.content(favoritesPlaces);
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(clickOnTabAction.stream, (controllerIndex) {
      tabController.value.data.index = controllerIndex;
      tabController.stateSubject.sink.add(tabController.value);
    });

    subscribe(onDeleteFromFavoritesAction.stream, (place) {
      _deleteFromFavorites(place);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    favoritePlaces.dispose();
    visitedPlaces.dispose();
    clickOnTabAction.dispose();
    onDeleteFromFavoritesAction.dispose();
    super.dispose();
  }

  ///
  /// Actions and functions
  ///

  /// The action is called when clicking on the tab
  final clickOnTabAction = Action<void>();

  /// Сalled when a place is removed from the favorites list
  final onDeleteFromFavoritesAction = Action<void>();

  /// Method for removing a place from favorites
  void _deleteFromFavorites(Place place) {
    placesInteractor.removeFromFavorites(place);
    favoritePlaces.content(
      favoritePlaces.stateSubject.value.data..remove(place),
    );
  }
}
