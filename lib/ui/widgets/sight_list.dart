///
/// Виджет [SightList] выводит список мест
/// через [DisplaySights], если длина списка > 0
/// или [EmptyList] - если массив пуст.
/// [cardType] - тип карточки ["default", "toVisit", "visited"]
///

import 'package:flutter/material.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widgets/empty_list.dart';

class SightList extends StatelessWidget {
  final String cardType;
  static List sights = mocks;
  const SightList({Key key, this.cardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sights.length != 0
        ? DisplaySights(sights: sights, cardType: cardType)
        : EmptyList(cardType: cardType);
  }
}

class DisplaySights extends StatelessWidget {
  final List sights;
  final String cardType;
  const DisplaySights({Key key, this.sights, this.cardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Column(
              children: mocks
                  .map((item) => SightCard(sight: item, cardType: cardType))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
