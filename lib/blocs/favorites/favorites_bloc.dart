import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favorites/favorites_event.dart';
import 'package:places/blocs/favorites/favorites_state.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/geo_position.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api/exceptions/network_exception.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/utils/check_distance.dart';

/// Bloc for favorites places
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final PlaceRepository _favoritesRepository;

  FavoritesBloc(this._favoritesRepository) : super(FavoritesLoadingProgress());

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    if (event is FavoritesLoad) {
      yield* _mapFavoritesLoadToState();
    }
  }

  Stream<FavoritesState> _mapFavoritesLoadToState() async* {
    try {
      // Получаем места
      final List<Place> favorites = await _favoritesRepository.loadPlaces();

      // Сортируем
      final List<Place> sortedFavorites = sortFavoritePlaces(favorites);

      yield FavoritesLoadSuccess(sortedFavorites);
    } on NetworkException catch (e) {
      debugPrint(
          "An NetworkException occurred in FavoritesBlock: ${e.toString()}");
      yield FavoritesLoadingFailed();
    } catch (e) {
      debugPrint(
          "An error occurred in FavoritesBlock: ${e.runtimeType} ${e.toString()}");
      yield FavoritesLoadingFailed();
    }
  }

  /// Function for sorting favorites list
  List<Place> sortFavoritePlaces(List<Place> favorites) {
    final GeoPosition userGeoposition = GeoPosition(59.914455, 29.770945);

    favorites.forEach((element) {
      element.distance = DistanceToPlace().check(
        userPoint: userGeoposition,
        checkPoint: GeoPosition(element.lat, element.lng),
      );
    });

    if (favorites.isNotEmpty)
      favorites.sort(
        (prev, next) {
          return prev.distance.compareTo(next.distance);
        },
      );

    return favorites;
  }
}
