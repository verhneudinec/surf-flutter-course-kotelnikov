import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/ui/screen/favorites_screen/favorites_screen.dart';
import 'package:places/ui/screen/favorites_screen/favorites_wm.dart';
import 'package:provider/provider.dart';

/// Favorites screen route
class FavoritesScreenRoute extends MaterialPageRoute {
  FavoritesScreenRoute()
      : super(
          builder: (context) => FavoritesScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => FavoritesWidgetModel(
      context.read<WidgetModelDependencies>(),
      context.read<PlacesInteractor>(),
      Navigator.of(context),
    );
