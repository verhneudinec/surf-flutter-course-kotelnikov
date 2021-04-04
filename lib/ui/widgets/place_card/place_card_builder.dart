import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/widgets/place_card/place_card.dart';
import 'package:places/ui/widgets/place_card/place_card_wm.dart';
import 'package:provider/provider.dart';

/// Builder for place card
class PlaceCardWidgetBuilder extends StatelessWidget {
  /// The place
  final Place place;

  /// The appearance of the card depends on [cardType]
  final String cardType;

  /// Action to remove a place from favorites
  final onDeleteFromFavoritesAction;

  const PlaceCardWidgetBuilder({
    Key key,
    @required this.place,
    @required this.cardType,
    this.onDeleteFromFavoritesAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlaceCard(
      widgetModelBuilder: (context) => PlaceCardWidgetModel(
        context.read<WidgetModelDependencies>(),
        placesInteractor: context.read<PlacesInteractor>(),
        navigator: Navigator.of(context),
        place: place,
        cardType: cardType,
        onDeleteFromFavoritesAction: onDeleteFromFavoritesAction,
      ),
    );
  }
}
