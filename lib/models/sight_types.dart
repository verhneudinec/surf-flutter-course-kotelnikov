import 'package:flutter/material.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';

/// Provider for place types.
class SightTypes with ChangeNotifier {
  final List _sightTypesData = [
    {
      "name": "hotel",
      "text": AppTextStrings.hotel,
      "icon": AppIcons.hotel,
      "selected": true,
    },
    {
      "name": "restourant",
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
