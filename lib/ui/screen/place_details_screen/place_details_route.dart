import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/ui/screen/place_details_screen/place_details_screen.dart';
import 'package:places/ui/screen/place_details_screen/place_details_wm.dart';
import 'package:provider/provider.dart';

/// Place details screen route
class PlaceDetailsRoute extends MaterialPageRoute {
  PlaceDetailsRoute(
    int placeId, {
    bool isBottomSheet,
  }) : super(
          builder: (context) => PlaceDetailsScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(
  BuildContext context, {
  @required int placeId,
  bool isBottomSheet,
}) =>
    PlaceDetailsWidgetModel(
      context.read<WidgetModelDependencies>(),
      context.read<PlacesInteractor>(),
      Navigator.of(context),
      placeId: placeId,
      isBottomSheet: isBottomSheet,
    );
