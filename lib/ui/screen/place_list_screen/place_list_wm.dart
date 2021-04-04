import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/add_place_screen/add_place_route.dart';
import 'package:relation/relation.dart';

/// Place list screen's widget model
class PlaceListWidgetModel extends WidgetModel {
  final PlacesInteractor placesInteractor;
  final NavigatorState navigator;
  final List<Place> places;

  PlaceListWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.placesInteractor,
    this.navigator, {
    this.places,
  }) : super(baseDependencies);

  final placesState = EntityStreamedState<List<Place>>(
    EntityState.loading(),
  );

  @override
  void onLoad() {
    _initStore();
    super.onLoad();
  }

  @override
  void onBind() {
    subscribe(onClickCreateButtonAction.stream, (_) {
      _onClickCreateButton();
    });
    super.onBind();
  }

  /// Action when clicking on the "Create a new location" button.
  final onClickCreateButtonAction = Action<void>();

  /// Function for initializing the state [placesState].
  void _initStore() async {
    try {
      if (placesInteractor.places.isEmpty) await placesInteractor.loadPlaces();

      final List<Place> loadedPlace = placesInteractor.places;

      placesState.content(loadedPlace);
    } on Exception catch (e) {
      handleError(e);
      placesState.error(e);
    }
  }

  /// To go to the [AddPlaceScreen] screen
  void _onClickCreateButton() {
    navigator.push(
      AddPlaceScreenRoute(),
    );
  }
}
