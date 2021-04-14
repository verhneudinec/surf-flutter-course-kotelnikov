import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api/exceptions/network_exception.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/utils/check_distance.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

/// Provider for an array of application locations.
/// Initialized with data from API.
class PlacesInteractor with ChangeNotifier {
  /// Application database.
  /// Initialized in [initFavoritesTable].
  AppDB _db;

  /// Repository for working with API
  PlaceRepository _placeRepository = PlaceRepository();

  /// Loaded places from [PlacesRepository]
  List<Place> _places = [];
  // TODO Убрать лишние поля в интеракторе

  /// Favorite places. Loaded from database.
  final _favoritePlaces = EntityStreamedState<List<Place>>(
    EntityState.content([]),
  );

  /// Favorite places with value `isVisited = true`.
  final _visitedPlaces = EntityStreamedState<List<Place>>(
    EntityState.content([]),
  );

  ///           ///
  ///  Getters  ///
  ///           ///

  List<Place> get places => _places;

  EntityStreamedState<List<Place>> get favoritePlaces => _favoritePlaces;

  EntityStreamedState<List<Place>> get visitedPlaces => _visitedPlaces;

  ///             ///
  ///  Functions  ///
  ///             ///

  /// Function for loading places from [PlacesRepository]
  Future<void> loadPlaces({int radius, String category}) async {
    try {
      final response = await _placeRepository.loadPlaces();
      _places = response;
    } catch (e) {
      rethrow;
    }
  }

  /// Function for loading place details from API
  Future<Place> loadPlaceDetails({@required int id}) async {
    try {
      final response = await _placeRepository.getPlaceDetails(id: id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Function for initializing the database [_db].
  /// This also loads the locations from db using [refreshFavoritePlaces].
  void initFavoritesTable(BuildContext context) {
    _db = context.read<AppDB>();

    refreshFavoritePlaces();
  }

  /// A function to update the state of [_favoritePlaces] and [_visitedPlaces]
  /// with data from the database.
  Future<void> refreshFavoritePlaces() async {
    final List<Place> favoritePlacesFromDB =
        await _db.favoritesDao.getFavoritePlaces;

    final List<Place> visitedPlacesFromDB =
        await _db.favoritesDao.getVisitedPlaces;

    _favoritePlaces.content(sortFavoritePlaces(favoritePlacesFromDB));

    _visitedPlaces.content(sortFavoritePlaces(visitedPlacesFromDB));
  }

  /// Function for sorting [_favoritePlaces] list
  List<Place> sortFavoritePlaces(List<Place> places) {
    final GeoPosition userGeoposition = GeoPosition(59.914455, 29.770945);

    places.forEach((element) {
      element.distance = DistanceToPlace().check(
        userPoint: userGeoposition,
        checkPoint: GeoPosition(element.lat, element.lng),
      );
    });

    if (places.isNotEmpty)
      places.sort(
        (prev, next) {
          return prev.distance.compareTo(next.distance);
        },
      );

    return places;
  }

  /// Function for checking the place in favorites
  bool isPlaceInFavorites(Place place) {
    return _favoritePlaces.value.data.contains(place);
  }

  /// Function for adding the place in favorites
  void addToFavorites(Place place) {
    _db.favoritesDao.savePlace(place);
    refreshFavoritePlaces();
  }

  /// Function for removing the place from favorites
  void removeFromFavorites(Place place) {
    _db.favoritesDao.deletePlace(place.id);
    refreshFavoritePlaces();
  }

  /// Function for adding place to visited
  void markPlaceAsVisited(Place place) {
    _db.favoritesDao.markPlaceAsVisited(place);
    refreshFavoritePlaces();
  }

  /// Function for adding a new place.
  Future<Place> addNewPlace(Place place) async {
    try {
      final newPlace = await _placeRepository.addNewPlace(place: place);

      _places.add(newPlace);

      notifyListeners();

      return newPlace;
    } on NetworkException catch (e) {
      throw e;
    } catch (e) {
      print(e);
    }
  }

  /// Method for uploading [photo] to the server.
  /// Returns the full url of the image.
  Future<String> uploadPhoto(File photo) async {
    try {
      final String photoUrl = await _placeRepository.uploadPhoto(photo);
      return photoUrl;
    } catch (_) {
      rethrow;
    }
  }

  /// A method for plotting a route to a location using the device's native map.
  Future<void> openNativeDeviceMap(Place place) async {
    /// Save it to the database as a visited place
    _db.favoritesDao.markPlaceAsVisited(place);

    /// Launch the map
    MapsLauncher.launchQuery(place.name);
    MapsLauncher.launchCoordinates(place.lat, place.lng);
  }

  /// Function for swapping favorite items.
  /// [oldIndex] - current element index,
  /// [newIndex] - index where the element should be inserted.
  void swapFavoriteItems(
    int oldIndex,
    int newIndex,
  ) {
    // TODO Переписать функцию swapFavoriteItems
    // Временно закомментировал
    //Place temp = _favoritePlaces[oldIndex];
    // _favoritePlaces.removeAt(oldIndex);
    // _favoritePlaces.insert(newIndex, temp);
    notifyListeners();
  }

  // TODO Переписать функцию getPlaceId для swapFavoriteItems
  int getPlaceId({
    Place place,
  }) {
    return _favoritePlaces.value.data.indexOf(place);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
