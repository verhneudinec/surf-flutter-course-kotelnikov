import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/widgets/imageLoaderBuilder.dart';

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
        width: double.infinity,
        decoration: AppDecorations.sightCardContainer,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 96,
              child: Image.network(
                sight.url,
                fit: BoxFit.cover,
                loadingBuilder: imageLoaderBuilder,
                errorBuilder: imageErrorBuilder,
              ),
            ),

            // Контейнер для создания эффекта градиента
            Container(
              decoration: AppDecorations.sightCardImageGradient,
              width: double.infinity,
              height: 96,
            ),
          ],
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
            child: Stack(
              children: [
                Image.asset("assets/icons/heart.png"),
                Positioned(
                  top: 4,
                  right: 3,
                  child: Container(
                      width: 3,
                      height: 5,
                      child: Image.asset("assets/icons/heart-child.png")),
                ),
              ],
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
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Отступ
          const SizedBox(
            height: 18,
          ),

          // Название места
          Container(
            constraints: BoxConstraints(maxWidth: 296),
            child: Text(
              sight.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.sightCardTitle,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          // Время работы
          Container(
            child: Text(
              sight.workingTime,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.sightCardWorkingTime,
            ),
          ),
        ],
      ),
    );
  }
}
