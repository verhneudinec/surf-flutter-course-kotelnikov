import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/domain/sight.dart';
import 'package:places/net/dio.dart';

/// Provider for an array of application locations.
/// Initialized with data from [mocks].
class Sights with ChangeNotifier {
  final List _sights = mocks;

  List get sights => _sights;

  /// This function is called when sight is added in the [AddSightScreen] screen.
  /// A prepared object of the [Sight] type comes to the function  input.
  void addSight(Sight newSight) {
    _sights.add(newSight);

    print(
      '''
      Добавлено новое место в массив моков:
      
      name: ${_sights.last.name} 
      details: "${_sights.last.details}"

      Всего в массиве  ${_sights.length} мест.
      ''',
    );

    notifyListeners();
  }
}
