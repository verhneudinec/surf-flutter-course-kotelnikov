import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/text_styles.dart';

class SightCard extends StatelessWidget {
  final Sight sight;
  const SightCard({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Container(
        height: 188,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            SightCardHeader(sight: sight),
            SightCardBody(sight: sight),
          ],
        ),
      ),
    );
  }
}

class SightCardHeader extends StatelessWidget {
  final Sight sight;
  const SightCardHeader({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Главное фото места
        Container(
          height: 92,
          child: Image.network(
            sight.url,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        // Тип места
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            sight.type,
            style: AppTextStyles.sightCardType,
          ),
        ),

        // Добавить в избранное
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            width: 20,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}

class SightCardBody extends StatelessWidget {
  final Sight sight;
  const SightCardBody({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      height: 92,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          // Название места
          Container(
            child: Text(
              sight.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.sightCardTitle,
            ),
          ),

          // Описание места
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Text(
              sight.details,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.sightCardDescription,
            ),
          ),
        ],
      ),
    );
  }
}
