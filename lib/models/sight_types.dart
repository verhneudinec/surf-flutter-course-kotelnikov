import 'package:flutter/material.dart';
import 'package:places/res/localization.dart';

/// Provider for place types.
class SightTypes with ChangeNotifier {
  final List _sightTypesData = [
    {
      "name": "hotel",
      "text": AppTextStrings.hotel,
      "icon": "assets/icons/categories/Hotel.svg",
      "selected": true,
    },
    {
      "name": "restourant",
      "text": AppTextStrings.restourant,
      "icon": "assets/icons/categories/Restourant.svg",
      "selected": true,
    },
    {
      "name": "particular_place",
      "text": AppTextStrings.particularPlace,
      "icon": "assets/icons/categories/Particular_place.svg",
      "selected": true,
    },
    {
      "name": "park",
      "text": AppTextStrings.park,
      "icon": "assets/icons/categories/Park.svg",
      "selected": true,
    },
    {
      "name": "museum",
      "text": AppTextStrings.museum,
      "icon": "assets/icons/categories/Museum.svg",
      "selected": true,
    },
    {
      "name": "cafe",
      "text": AppTextStrings.cafe,
      "icon": "assets/icons/categories/Cafe.svg",
      "selected": true,
    },
  ];

  List get sightTypesData => _sightTypesData;

  /// Function to clear all active (selected) types
  void onCleanAllSelectedTypes() {
    _sightTypesData.forEach(
      (sightType) {
        sightType["selected"] = false;
      },
    );
    notifyListeners();
  }

  /// Function to clear a specific selected type by index
  void onCleanSelectedType(index) {
    _sightTypesData.elementAt(index).selected = false;
    notifyListeners();
  }

  /// The function is called when you click on a sight type.
  /// Inverts the value of the selected type (by index)
  void onTypeClickHandler(index) {
    _sightTypesData.elementAt(index)["selected"] =
        !_sightTypesData.elementAt(index)["selected"];

    notifyListeners();
  }
}
