import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/domain/sight.dart';

/// Provider for working with the [VisitingScreen] screen.
/// Initialized with data from [mocks].
class FavoriteSights with ChangeNotifier {
  final List _favorites = mocks;

  List get favorites => _favorites;
  List get visitedFavoriteSights =>
      _favorites.where((sight) => sight.isVisited).toList();
  List get unvisitedFavoriteSights =>
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
    oldIndex,
    newIndex,
  ) {
    Sight temp = _favorites[oldIndex];
    _favorites.removeAt(oldIndex);
    _favorites.insert(newIndex, temp);
    notifyListeners();
  }

  int getSightId({
    Sight sight,
  }) {
    return _favorites.indexOf(sight);
  }
}

/// Provider for working with the [VisitingScreen] screen.
/// Initialized with data from [mocks].
class FavoriteSights2 with ChangeNotifier {
  final List _visitedFavoriteSights =
      mocks.where((sight) => sight.isVisited).toList();
  final List _unvisitedFavoriteSights =
      mocks.where((sight) => !sight.isVisited).toList();

  List get visitedFavoriteSights => _visitedFavoriteSights;
  List get unvisitedFavoriteSights => _unvisitedFavoriteSights;

  void deleteSightFromFavorites(String sightName) {
    /// пока что удаление происходит по имени
    /// в будущем при работе с api, думаю, будет id места,
    /// по которому можно однозначно идентифицировать место
    /// и удалить именно его, а не место с похожим названием
    _visitedFavoriteSights.removeWhere((sight) => sight.name == sightName);
    notifyListeners();
  }

  /// When dragging an item in the list
  void onDraggingSight(
    oldIndex,
    newIndex,
  ) {
    Sight temp = _unvisitedFavoriteSights[oldIndex];
    _unvisitedFavoriteSights.removeAt(oldIndex);
    _unvisitedFavoriteSights.insert(newIndex, temp);
    notifyListeners();
  }

  int getSightId({
    bool gettingFromVisited,
    Sight sight,
  }) {
    if (gettingFromVisited == true)
      return _visitedFavoriteSights.indexOf(sight);
    else
      return _unvisitedFavoriteSights.indexOf(sight);
  }
}
