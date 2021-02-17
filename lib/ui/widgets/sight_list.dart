import 'package:flutter/material.dart';
import 'package:places/res/card_types.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/empty_list.dart';
import 'package:places/domain/sight.dart';
import 'package:provider/provider.dart';
import 'package:places/models/favorite_sights.dart';

/// The [SightList] widget displays a list of places
/// via [DisplaySights], if list length> 0
/// or [EmptyList] -if the array is empty.
/// [cardType] - card type [CardTypes.general], [CardTypes.unvisited], [CardTypes.visited].
class SightList extends StatelessWidget {
  final String cardType;
  final List sights;
  final onDeleteSight;
  const SightList({
    Key key,
    this.cardType,
    this.sights,
    this.onDeleteSight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sights.isNotEmpty == true
        ? DisplaySights(
            sights: sights,
            cardType: cardType,
            onDeleteSight: onDeleteSight,
          )
        : Center(
            child: SizedBox(
              width: 255,
              height: MediaQuery.of(context).size.height -
                  250, // TODO исправить размеры, Expanded
              child: EmptyList(cardType: cardType),
            ),
          );
  }
}

class DisplaySights extends StatelessWidget {
  final List sights;
  final String cardType;
  final onDeleteSight;
  const DisplaySights({
    Key key,
    this.sights,
    this.cardType,
    this.onDeleteSight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Column(
            children: sights
                .map((sight) => _sightListItem(
                      context,
                      sight,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  /// Sights list item
  Widget _sightListItem(
    BuildContext context,
    Sight sight,
  ) {
    return cardType == CardTypes.general
        ? _sightCardBuilder(sight)
        : _favoriteSightCardBuilder(context, sight);
  }

  /// Builder for a regular card with the CardTypes.general type
  Widget _sightCardBuilder(Sight sight) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: SightCard(
        key: ValueKey(sight.name),
        sight: sight,
        cardType: cardType,
      ),
    );
  }

  /// Builder for "Favorites" page cards
  Widget _favoriteSightCardBuilder(BuildContext context, Sight sight) {
    /// [_onDraggingSight] called when dragging an item in the list
    void _onDraggingSight(int oldIndex, int newIndex) {
      context.read<FavoriteSights>().onDraggingSight(oldIndex, newIndex);
    }

    int _sightId = context.watch<FavoriteSights>().getSightId(sight: sight);

    return Material(
      type: MaterialType.transparency,
      child: Draggable<String>(
        key: ValueKey(_sightId.toString()),
        data: _sightId.toString(), // TODO Sight.id
        axis: Axis.vertical,
        feedback: _draggableSightFeedback(context, sight),
        childWhenDragging: SizedBox.shrink(),
        child: DragTarget<String>(
          builder:
              (BuildContext context, List<String> incoming, List rejected) {
            return _sightCardBuilder(sight);
          },
          onWillAccept: (oldIndex) {
            return true;
          },
          onAccept: (oldIndex) {
            _onDraggingSight(int.tryParse(oldIndex), _sightId);
          },
        ),
      ),
    );
  }

  Widget _draggableSightFeedback(BuildContext context, Sight sight) {
    return Material(
      color: Colors.transparent,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: _sightCardBuilder(sight),
      ),
    );
  }

  Widget _dragTargetBackground(BuildContext context, Sight sight) {
    return Material(
      color: Colors.transparent,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: Container(color: Colors.red),
      ),
    );
  }
}
