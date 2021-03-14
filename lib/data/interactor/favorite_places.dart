import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

/// Provider for working with the [VisitingScreen] screen.
/// Initialized with data from [mocks].
// class FavoritePlaces with ChangeNotifier {
//   final List<Place> _favorites = [];

//   List<Place> get favorites => _favorites;
//   List<Place> get visitedFavoritePlaces => _favorites; // TODO Favorites DB
//   List<Place> get unvisitedFavoritePlaces =>
//       _favorites; // TODO where((place) => !place.isVisited).toList()

//   void deletePlaceFromFavorites(String placeName) {
//     /// пока что удаление происходит по имени
//     /// в будущем при работе с api, думаю, будет id места,
//     /// по которому можно однозначно идентифицировать место
//     /// и удалить именно его, а не место с похожим названием
//     _favorites.removeWhere((place) => place.name == placeName);
//     notifyListeners();
//   }

// }
