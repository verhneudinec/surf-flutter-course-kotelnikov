import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/place_list_screen/place_list_wm.dart';
import 'package:places/ui/screen/place_list_screen/places_list_screen.dart';
import 'package:provider/provider.dart';

/// Place list screen route
class PlaceListScreenRoute extends MaterialPageRoute {
  PlaceListScreenRoute({List<Place> places})
      : super(
          builder: (context) => PlaceListScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(
  BuildContext context, {
  List<Place> places,
}) =>
    PlaceListWidgetModel(
      context.read<WidgetModelDependencies>(),
      context.read<PlacesInteractor>(),
      Navigator.of(context),
      places: places,
    );
