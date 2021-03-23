import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api/exceptions/network_exception.dart';
import 'package:places/data/repository/place_repository.dart';

part 'places_store.g.dart';

/// MobX store for the list of places.
/// [loadPlaces] loads data from the [PlaceRepository].
/// [places] returns interest places.
class PlacesStore = PlacesStoreBase with _$PlacesStore;

abstract class PlacesStoreBase with Store {
  @observable
  ObservableFuture<List<Place>> places = ObservableFuture.value([]);

  /// Function for loading places from [PlacesRepository]
  @action
  Future<void> loadPlaces({
    int radius,
    String category,
  }) async {
    try {
      final response = await PlaceRepository().loadPlaces();
      places = ObservableFuture.value(response);
    } on NetworkException catch (e) {
      places = ObservableFuture.error(e);
    } catch (e) {
      places = ObservableFuture.error(e);
    }
  }
}
