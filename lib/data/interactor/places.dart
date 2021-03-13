import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api/api_client.dart';
import 'package:places/data/repository/place_repository.dart';

/// Provider for an array of application locations.
/// Initialized with data from [mocks].
class Places with ChangeNotifier {
  List<Place> _places = [];

  Future<void> getPlaces() async {
    final response = await PlaceRepository().loadPlace();
    _places = response;
  }

  List<Place> get places => _places;

  /// This function is called when place is added in the [AddPlaceScreen] screen.
  /// A prepared object of the [Place] type comes to the function  input.
  void addPlace(Place newPlace) {
    _places.add(newPlace);

    print(
      '''
      Добавлено новое место в массив моков:
      
      name: ${_places.last.name} 
      details: "${_places.last.description}"

      Всего в массиве  ${_places.length} мест.
      ''',
    );

    notifyListeners();
  }
}
