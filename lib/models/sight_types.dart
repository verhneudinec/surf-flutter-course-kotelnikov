import 'package:flutter/material.dart';
import 'package:places/res/localization.dart';

/// Provider for place types.
class SightTypes with ChangeNotifier {
  final List _sightTypesData = [
    {
      "name": "hotel",
      "text": AppTextStrings.hotel,
      "icon": "assets/icons/categories/Hotel.svg",
      "selected": false,
    },
    {
      "name": "restourant",
      "text": AppTextStrings.restourant,
      "icon": "assets/icons/categories/Restourant.svg",
      "selected": false,
    },
    {
      "name": "particular_place",
      "text": AppTextStrings.particularPlace,
      "icon": "assets/icons/categories/Particular_place.svg",
      "selected": false,
    },
    {
      "name": "park",
      "text": AppTextStrings.park,
      "icon": "assets/icons/categories/Park.svg",
      "selected": false,
    },
    {
      "name": "museum",
      "text": AppTextStrings.museum,
      "icon": "assets/icons/categories/Museum.svg",
      "selected": false,
    },
    {
      "name": "cafe",
      "text": AppTextStrings.cafe,
      "icon": "assets/icons/categories/Cafe.svg",
      "selected": false,
    },
  ];

  List get sightTypesData => _sightTypesData;
}
