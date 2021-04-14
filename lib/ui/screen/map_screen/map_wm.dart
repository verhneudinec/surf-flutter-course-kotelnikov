import 'package:flutter/material.dart' hide Action;
import 'package:geolocator/geolocator.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/durations.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/screen/add_place_screen/add_place_route.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Place list screen's widget model
class MapScreenWidgetModel extends WidgetModel {
  final PlacesSearchInteractor placesSearchInteractor;
  final NavigatorState navigator;

  MapScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.placesSearchInteractor,
    this.navigator,
  ) : super(baseDependencies);

  /// Last open location
  final placeState = StreamedState<Place>();

  /// Map controller
  YandexMapController mapController;

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    subscribe(initMapAction.stream, (yandexMapController) {
      mapController = yandexMapController;

      mapController.toggleNightMode(
        enabled: navigator.context.read<SettingsInteractor>().isDarkMode,
      );

      _loadMap();
    });

    subscribe(onClickCreateButtonAction.stream, (_) => _onClickCreateButton());

    subscribe(loadMapAction.stream, (_) => _loadMap());

    subscribe(showMeAction.stream, (_) => mapController.moveToUser());

    super.onBind();
  }

  /// Action when clicking on the "Create a new location" button.
  final initMapAction = Action<void>();

  /// Action to load user position and places by search query
  final loadMapAction = Action<void>();

  final showMeAction = Action<void>();

  /// Action when clicking on the "Create a new location" button.
  final onClickCreateButtonAction = Action<void>();

  /// Function for loading user position and places by search query
  void _loadMap() async {
    try {
      /// Get the geoposition and set it
      Position userPosition = await navigator.context
          .read<PlacesSearchInteractor>()
          .getUserPosition();

      /// Show the user on the map
      mapController.showUserLayer(
        iconName: AppIcons.userOnMap,
        arrowName: AppIcons.userOnMap,
        accuracyCircleFillColor:
            Theme.of(navigator.context).accentColor.withOpacity(.12),
      );

      /// Navigate to the user
      mapController.move(
        point: Point(
          latitude: userPosition.latitude,
          longitude: userPosition.longitude,
        ),
      );

      /// Get search results
      final List<Place> searchResults =
          await placesSearchInteractor.searchPlaces();

      /// And add the results to the map
      _placemarkTagging(searchResults);
    } catch (_) {
      rethrow;
    }
  }

  /// Function for adding places to the map
  void _placemarkTagging(List<Place> places) {
    /// Places that were clicked on the map
    List<Place> placeViewingHistory = [];

    /// Iterate the search results and add placemarks
    places.forEach(
      (place) {
        final Placemark placemark = Placemark(
          style: PlacemarkStyle(
            iconName: AppIcons.inactivePlaceOnMap,
            scale: 3,
            opacity: 1,
          ),
          point: Point(
            latitude: place.lat,
            longitude: place.lng,
          ),
          onTap: (_) => _onPlacemarkTap(place, placeViewingHistory),
        );

        mapController.addPlacemark(placemark);
      },
    );
  }

  /// Called when the label is clicked. Shows a place card,
  /// moves the camera and makes the mark active.
  void _onPlacemarkTap(
    Place place,
    List<Place> placeViewingHistory,
  ) {
    /// Remove the last active label from the map
    if (placeViewingHistory.isNotEmpty)
      mapController.removePlacemark(mapController.placemarks.last);

    Placemark activePlacemark = Placemark(
      style: PlacemarkStyle(
        iconName: AppIcons.activePlaceOnMap,
        scale: 1.5,
        opacity: 1,
      ),
      point: Point(
        latitude: place.lat,
        longitude: place.lng,
      ),
    );

    /// Add place to viewed
    placeViewingHistory.add(place);

    /// Update the displayed place
    placeState.accept(place);

    mapController.addPlacemark(activePlacemark);
    mapController.move(
      animation: MapAnimation(
        smooth: true,
        duration: 1,
      ),
      point: Point(
        latitude: place.lat,
        longitude: place.lng,
      ),
    );
  }

  /// To go to the [AddPlaceScreen] screen
  void _onClickCreateButton() {
    navigator.push(
      AddPlaceScreenRoute(),
    );
  }
}
