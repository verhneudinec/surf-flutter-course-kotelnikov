import 'package:moor/moor.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/database/favorite_places/favorite_table.dart';
import 'package:places/data/model/place.dart';

part 'favorite_dao.g.dart';

/// Data access object for [Favorites] table.
@UseDao(tables: [Favorites])
class FavoritesDao extends DatabaseAccessor<AppDB> with _$FavoritesDaoMixin {
  FavoritesDao(AppDB attachedDatabase) : super(attachedDatabase);

  /// Геттер избранных мест. Получает места только со значением `isVisited = false`.
  /// Возвращает готовый для использования список List<Place>.
  Future<List<Place>> get getFavoritePlaces async {
    final List<Favorite> response = await select(favorites).get();
    return response
        .where((element) => !element.isVisited)
        .map((tableItem) => _convertToPlace(tableItem))
        .toList();
  }

  /// Геттер посещенных мест. Получает места только со значением `isVisited = true`.
  /// Возвращает готовый для использования список List<Place>.
  Future<List<Place>> get getVisitedPlaces async {
    final List<Favorite> response = await select(favorites).get();
    return response
        .where((element) => element.isVisited)
        .map((tableItem) => _convertToPlace(tableItem))
        .toList();
  }

  /// Save place in favorites table
  Future<void> savePlace(Place place) async {
    into(favorites).insert(
      _convertToFavoriteCompanion(place),
    );
  }

  /// Removing a place from the table by id.
  Future<void> deletePlace(int placeId) async {
    delete(favorites)
      ..where(
        (table) => table.placeId.equals(placeId),
      )
      ..go();
  }

  /// Function for adding a place to favorites
  Future<void> markPlaceAsVisited(Place place) async {
    /// If the place is transferred from the favorites,
    /// and not directly from the map screen, then we delete it from the database.
    deletePlace(place.id);

    into(favorites).insert(
      _convertToFavoriteCompanion(
        place,
        isVisited: true,
      ),
    );
  }

  /// Function for converting from [Favorite] to [Place].
  Place _convertToPlace(Favorite tableItem) {
    return Place(
      id: tableItem.placeId,
      name: tableItem.placeName,
      urls: [tableItem.placeImage],
      placeType: tableItem.placeType,
      lat: tableItem.placeLat,
      lng: tableItem.placeLng,
      visitDate: tableItem.visitDate,
      isVisited: tableItem.isVisited,
    );
  }

  /// Function for converting from [Place] to [FavoritesCompanion]
  /// for further addition to the database.
  /// Need to pass the value of `isVisited` if the place is added to visited.
  FavoritesCompanion _convertToFavoriteCompanion(
    Place place, {
    bool isVisited = false,
  }) {
    /// Необходимо
    return FavoritesCompanion(
      placeId: Value(place.id),
      placeName: Value(place.name),
      placeImage: Value(place.urls[0]),
      placeType: Value(place.placeType),
      placeLat: Value(place.lat),
      placeLng: Value(place.lng),
      visitDate: Value(place.visitDate ??
          DateTime.now().add(
            Duration(days: 30),
          )),
      isVisited: Value(isVisited),
    );
  }
}
