import 'package:flutter/material.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';

/// Class for converting place type to icon or string
class PlaceTypes {
  PlaceTypes({Key key});

  static const String hotel = "hotel",
      restaurant = "restaurant",
      park = "park",
      museum = "museum",
      cafe = "cafe",
      particular_place = "particular_place";

  /// Converts place type to text from [AppTextStrings]
  static String stringFromPlaceType(String placeType) {
    switch (placeType) {
      case hotel:
        return AppTextStrings.hotel;
        break;
      case restaurant:
        return AppTextStrings.restourant;
        break;
      case park:
        return AppTextStrings.park;
        break;
      case museum:
        return AppTextStrings.museum;
        break;
      case cafe:
        return AppTextStrings.cafe;
        break;
      default:
        return AppTextStrings.particularPlace;
        break;
    }
  }

  /// Convert place type to svg icon path
  static String iconFromPlaceType(String placeType) {
    switch (placeType) {
      case hotel:
        return AppIcons.hotel;
        break;
      case restaurant:
        return AppIcons.restourant;
        break;
      case park:
        return AppIcons.park;
        break;
      case museum:
        return AppIcons.museum;
        break;
      case cafe:
        return AppIcons.cafe;
        break;
      default:
        return AppIcons.particularPlace;
        break;
    }
  }
}
