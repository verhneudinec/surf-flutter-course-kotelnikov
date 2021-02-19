import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/domain/sight.dart';

/// Provider for working with the [VisitingScreen] screen.
/// Initialized with data from [mocks].
class FavoriteSights with ChangeNotifier {
  final List _favorites = mocks;
  // final List _favoritesTest = mocks.map((sight) {
  //   sight['newFieldOfObject'] = false;
  //   return sight;
  // }).toList();

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
}
