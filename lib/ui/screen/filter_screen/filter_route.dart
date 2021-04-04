import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/ui/screen/filter_screen/filter_screen.dart';
import 'package:places/ui/screen/filter_screen/filter_wm.dart';
import 'package:provider/provider.dart';

/// Filter screen route
class FilterScreenRoute extends MaterialPageRoute {
  FilterScreenRoute()
      : super(
          builder: (context) => FilterScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => FilterWidgetModel(
      context.read<WidgetModelDependencies>(),
      context.read<PlacesSearchInteractor>(),
      Navigator.of(context),
    );
