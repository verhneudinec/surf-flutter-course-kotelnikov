import 'package:flutter/material.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/utils/check_distance.dart';

/// Provider for an array of application locations.
/// Initialized with data from API.
class PlacesInteractor with ChangeNotifier {
  List<Place> _places = [];
  List<Place> _favoritePlaces = [];

  /// Places from [PlacesRepository]
  List<Place> get places => _places;

  /// Places from [_favoritePlaces]
  List<Place> get getFavoritePlaces =>
      _favoritePlaces.where((place) => !place.isVisited).toList();

  /// Visited places from [PlacesRepository]
  List<Place> get getVisitedPlaces =>
      _favoritePlaces.where((place) => place.isVisited).toList();

  /// Function for loading places from [PlacesRepository]
  Future<void> loadPlaces({int radius, String category}) async {
    final response = await PlaceRepository().loadPlaces();
    _places = response;

    notifyListeners();
  }

  /// Function for loading place details from API
  Future<Place> loadPlaceDetails({int id}) async {
    final Place place = await PlaceRepository().getPlaceDetails(id: id);
    return place;
  }

  /// Function for sorting [_favoritePlaces] list
  void sortFavoritePlaces() {
    final GeoPosition userGeoposition = GeoPosition(59.914455, 29.770945);

    _favoritePlaces.forEach((element) {
      element.distance = DistanceToPlace().check(
        userPoint: userGeoposition,
        checkPoint: GeoPosition(element.lat, element.lng),
      );
    });

    if (_favoritePlaces.isNotEmpty)
      _favoritePlaces.sort(
        (prev, next) {
          return prev.distance.compareTo(next.distance);
        },
      );
  }

  /// Function for checking the place in favorites
  bool isPlaceInFavorites(Place place) {
    return _favoritePlaces.contains(place);
  }

  /// Function for adding the place in favorites
  void addToFavorites(Place place) {
    _favoritePlaces.add(place);
    notifyListeners();
  }

  /// Function for removing the place from favorites
  void removeFromFavorites(Place place) {
    _favoritePlaces.removeWhere((item) => item.id == place.id);
    print("Удалено из избранного");
    notifyListeners();
  }

  /// Function for adding place to visited
  void addToVisitingPlaces(Place place) {
    _favoritePlaces.firstWhere((item) => item.id == place.id).isVisited = true;
    print("Добавлено в избранное");
    notifyListeners();
  }

  void addNewPlace(Place place) async {
    final newPlace = await PlaceRepository().addNewPlace(place: place);

    _places.add(newPlace);

    notifyListeners();
  }

  /// Function for swapping favorite items.
  /// [oldIndex] - current element index,
  /// [newIndex] - index where the element should be inserted.
  void swapFavoriteItems(
    int oldIndex,
    int newIndex,
  ) {
    Place temp = _favoritePlaces[oldIndex];
    _favoritePlaces.removeAt(oldIndex);
    _favoritePlaces.insert(newIndex, temp);
    notifyListeners();
  }

  int getPlaceId({
    Place place,
  }) {
    return _favoritePlaces.indexOf(place);
  }
}
