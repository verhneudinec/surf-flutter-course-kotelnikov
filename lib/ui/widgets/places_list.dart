import 'package:flutter/material.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/ui/widgets/place_card.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/data/model/place.dart';
import 'package:provider/provider.dart';

/// The [PlaceList] widget displays a list of places
/// if list length > 0 or [ErrorStub] - if the array is empty.
/// [cardType] - card type [CardTypes.general],
/// [CardTypes.unvisited], [CardTypes.visited].
class PlaceList extends StatelessWidget {
  final String cardsType;
  final List places;
  final void onDeletePlace;
  const PlaceList({
    Key key,
    @required this.cardsType,
    @required this.places,
    this.onDeletePlace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return SliverGrid(
      delegate: SliverChildListDelegate(
        places.isNotEmpty
            ? places
                .map((place) => _placeListItem(
                      context,
                      place,
                      _isPortraitOrientation,
                    ))
                .toList()
            : [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 330,
                    child: cardsType == CardTypes.unvisited
                        ? ErrorStub(
                            icon: AppIcons.card,
                            title: AppTextStrings.emptyPageTitle,
                            subtitle: AppTextStrings.emptyPageSubtitleUnvisited,
                          )
                        : ErrorStub(
                            icon: AppIcons.go,
                            title: AppTextStrings.emptyPageTitle,
                            subtitle: cardsType == CardTypes.general
                                ? AppTextStrings.emptyPageSubtitleDefault
                                : AppTextStrings.emptyPageSubtitleVisited,
                          ),
                  ),
                )
              ],
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _isPortraitOrientation ? 1 : 2,
        childAspectRatio: _isPortraitOrientation &&
                cardsType ==
                    CardTypes.general // TODO Fix orientation aspect ratio
            ? 3 / 1.35
            : 3 / 1.55,
      ),
    );
  }

  Widget _placeListItem(
    BuildContext context,
    Place place,
    bool isPortraitOrientation,
  ) {
    return cardsType == CardTypes.general
        ? _placeCardBuilder(place)
        : _favoritePlaceCardBuilder(context, place);
  }

  /// Builder for a regular card with the CardTypes.general type
  Widget _placeCardBuilder(Place place) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: PlaceCard(
        key: ValueKey(place.name),
        place: place,
        cardType: cardsType,
      ),
    );
  }

  /// Builder for "Favorites" page cards
  Widget _favoritePlaceCardBuilder(BuildContext context, Place place) {
    /// [_onDraggingPlace] called when dragging an item in the list
    void _onDraggingPlace(int oldIndex, int newIndex) {
      context.read<PlacesInteractor>().swapFavoriteItems(oldIndex, newIndex);
    }

    int _placeId = context.watch<PlacesInteractor>().getPlaceId(place: place);

    return Material(
      type: MaterialType.transparency,
      child: LongPressDraggable<String>(
        key: ValueKey(place.name),
        data: _placeId.toString(), // TODO Place.id
        axis: Axis.vertical,
        feedback: _draggablePlaceFeedback(context, place),
        childWhenDragging: SizedBox.shrink(),
        child: DragTarget<String>(
          builder:
              (BuildContext context, List<String> incoming, List rejected) {
            return _placeCardBuilder(place);
          },
          onWillAccept: (oldIndex) {
            return true;
          },
          onAccept: (oldIndex) {
            _onDraggingPlace(int.tryParse(oldIndex), _placeId);
          },
        ),
      ),
    );
  }

  Widget _draggablePlaceFeedback(BuildContext context, Place place) {
    return Material(
      color: Colors.transparent,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: _placeCardBuilder(place),
      ),
    );
  }
}
