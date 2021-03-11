import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/data/model/place.dart';

/// Provider for working with the [VisitingScreen] screen.
/// Initialized with data from [mocks].
class FavoriteSights with ChangeNotifier {
  final List<Place> _favorites = mocks;

  List<Place> get favorites => _favorites;
  List<Place> get visitedFavoriteSights =>
      _favorites.where((sight) => sight.isVisited).toList();
  List<Place> get unvisitedFavoriteSights =>
      _favorites.where((sight) => !sight.isVisited).toList();

  void deleteSightFromFavorites(String sightName) {
    /// пока что удаление происходит по имени
    /// в будущем при работе с api, думаю, будет id места,
    /// по которому можно однозначно идентифицировать место
    /// и удалить именно его, а не место с похожим названием
    _favorites.removeWhere((sight) => sight.name == sightName);
    notifyListeners();
  }

  /// When dragging an item in the list
  void onDraggingSight(
    int oldIndex,
    int newIndex,
  ) {
    Place temp = _favorites[oldIndex];
    _favorites.removeAt(oldIndex);
    _favorites.insert(newIndex, temp);
    notifyListeners();
  }

  int getSightId({
    Place sight,
  }) {
    return _favorites.indexOf(sight);
  }
}
