import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/ui/screen/favorites_screen/favorites_screen.dart';
import 'package:places/ui/screen/favorites_screen/favorites_wm.dart';
import 'package:places/ui/screen/search_screen/search_screen.dart';
import 'package:places/ui/screen/search_screen/search_wm.dart';
import 'package:provider/provider.dart';

/// Search screen route
class SearchScreenRoute extends MaterialPageRoute {
  SearchScreenRoute()
      : super(
          builder: (context) => SearchScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => SearchWidgetModel(
      context.read<WidgetModelDependencies>(),
      context.read<PlacesSearchInteractor>(),
      Navigator.of(context),
    );
