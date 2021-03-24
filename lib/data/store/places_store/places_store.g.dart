// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlacesStore on PlacesStoreBase, Store {
  final _$placesAtom = Atom(name: 'PlacesStoreBase.places');

  @override
  ObservableFuture<List<Place>> get places {
    _$placesAtom.reportRead();
    return super.places;
  }

  @override
  set places(ObservableFuture<List<Place>> value) {
    _$placesAtom.reportWrite(value, super.places, () {
      super.places = value;
    });
  }

  final _$loadPlacesAsyncAction = AsyncAction('PlacesStoreBase.loadPlaces');

  @override
  Future<void> loadPlaces({int radius, String category}) {
    return _$loadPlacesAsyncAction
        .run(() => super.loadPlaces(radius: radius, category: category));
  }

  @override
  String toString() {
    return '''
places: ${places}
    ''';
  }
}
