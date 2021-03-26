import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/ui/screen/add_place_screen/add_place_screen.dart';
import 'package:places/ui/screen/add_place_screen/add_place_wm.dart';
import 'package:provider/provider.dart';

/// Add place screen route
class AddPlaceScreenRoute extends MaterialPageRoute {
  AddPlaceScreenRoute()
      : super(
          builder: (context) => AddPlaceScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => AddPlaceWidgetModel(
      context.read<WidgetModelDependencies>(),
      context.read<PlacesInteractor>(),
      Navigator.of(context),
    );
