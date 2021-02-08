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
}
