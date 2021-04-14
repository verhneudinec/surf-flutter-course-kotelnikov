import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/map_screen/map_screen.dart';
import 'package:places/ui/screen/map_screen/map_wm.dart';
import 'package:provider/provider.dart';

/// Place list screen route
class MapScreenRoute extends MaterialPageRoute {
  MapScreenRoute({List<Place> places})
      : super(
          builder: (context) => MapScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => MapScreenWidgetModel(
      context.read<WidgetModelDependencies>(),
      context.read<PlacesSearchInteractor>(),
      Navigator.of(context),
    );
