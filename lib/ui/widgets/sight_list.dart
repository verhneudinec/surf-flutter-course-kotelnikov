import 'package:flutter/material.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/domain/sight.dart';
import 'package:provider/provider.dart';
import 'package:places/models/favorite_sights.dart';

/// The [SightList] widget displays a list of places
/// if list length > 0 or [ErrorStub] - if the array is empty.
/// [cardType] - card type [CardTypes.general],
/// [CardTypes.unvisited], [CardTypes.visited].
class SightList extends StatelessWidget {
  final String cardsType;
  final List sights;
  final void onDeleteSight;
  const SightList({
    Key key,
    @required this.cardsType,
    @required this.sights,
    this.onDeleteSight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return SliverGrid(
      delegate: SliverChildListDelegate(
        sights.isNotEmpty
            ? sights
                .map((sight) => _sightListItem(
                      context,
                      sight,
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
        childAspectRatio: _isPortraitOrientation ? 3 / 1.51 : 3 / 1.7,
      ),
    );
  }

  Widget _sightListItem(
    BuildContext context,
    Sight sight,
    bool isPortraitOrientation,
  ) {
    return cardsType == CardTypes.general
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
        cardType: cardsType,
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
      child: LongPressDraggable<String>(
        key: ValueKey(sight.name),
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
}
