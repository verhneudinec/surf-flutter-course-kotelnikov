import 'package:flutter/material.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/empty_list.dart';

/// The [SightList] widget displays a list of places
/// via [DisplaySights], if list length> 0
/// or [EmptyList] -if the array is empty.
/// [cardType] -card type ["default", "toVisit", "visited"]
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
        : EmptyList(cardType: cardType);
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
                .map((sight) => SightCard(
                      key: ValueKey(sight.name),
                      sight: sight,
                      cardType: cardType,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
