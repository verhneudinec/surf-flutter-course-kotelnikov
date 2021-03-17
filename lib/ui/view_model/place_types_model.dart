import 'package:flutter/material.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';

/// Provider for place types.
class PlaceTypes with ChangeNotifier {
  final List<Map<String, Object>> _placeTypesData = [
    {
      "name": "hotel",
      "text": AppTextStrings.hotel,
      "icon": AppIcons.hotel,
      "selected": true,
    },
    {
      "name": "restaurant",
      "text": AppTextStrings.restourant,
      "icon": AppIcons.restourant,
      "selected": true,
    },
    {
      "name": "particular_place",
      "text": AppTextStrings.particularPlace,
      "icon": AppIcons.particularPlace,
      "selected": true,
    },
    {
      "name": "park",
      "text": AppTextStrings.park,
      "icon": AppIcons.park,
      "selected": true,
    },
    {
      "name": "museum",
      "text": AppTextStrings.museum,
      "icon": AppIcons.museum,
      "selected": true,
    },
    {
      "name": "cafe",
      "text": AppTextStrings.cafe,
      "icon": AppIcons.cafe,
      "selected": true,
    },
  ];

  List<Map<String, Object>> get placeTypesData => _placeTypesData;

  /// Function to clear all active (selected) types
  void onCleanAllSelectedTypes() {
    _placeTypesData.forEach(
      (placeType) {
        placeType["selected"] = false;
      },
    );
    notifyListeners();
  }

  /// The function is called when you click on a place type.
  /// Inverts the value of the selected type (by index)
  void onTypeClickHandler(int index) {
    _placeTypesData.elementAt(index)["selected"] =
        !_placeTypesData.elementAt(index)["selected"];
    notifyListeners();
  }
}
