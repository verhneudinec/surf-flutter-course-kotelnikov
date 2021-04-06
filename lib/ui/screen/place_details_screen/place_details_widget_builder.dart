import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/ui/screen/place_details_screen/place_details_screen.dart';
import 'package:places/ui/screen/place_details_screen/place_details_wm.dart';
import 'package:provider/provider.dart';

/// Widget for displaying place details with built-in builder.
class PlaceDetailsWidget extends StatelessWidget {
  final int placeId;
  final List<String> placeImages;

  const PlaceDetailsWidget(
    this.placeId, {
    @required this.placeImages,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlaceDetailsScreen(
      widgetModelBuilder: (context) => PlaceDetailsWidgetModel(
        context.read<WidgetModelDependencies>(),
        context.read<PlacesInteractor>(),
        Navigator.of(context),
        placeId: placeId,
        placeImages: placeImages,
        isBottomSheet: false,
      ),
    );
  }
}
