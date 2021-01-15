import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/widgets/imageLoaderBuilder.dart';

class SightCard extends StatelessWidget {
  final Sight sight;
  final dynamic cardType;
  const SightCard({
    Key key,
    this.sight,
    this.cardType,
  }) : super(key: key);

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
        decoration: AppDecorations.sightCardContainer.copyWith(
          color: Theme.of(context).cardColor,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SightCardHeader(sight: sight, cardType: cardType ?? "default"),
            SightCardBody(sight: sight, cardType: cardType ?? "default"),
          ],
        ),
      ),
    );
  }
}

class SightCardHeader extends StatelessWidget {
  final Sight sight;
  final String cardType;
  const SightCardHeader({Key key, this.sight, this.cardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Главное фото места
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

        // Тип места
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            sight.type,
            style: AppTextStyles.sightCardType.copyWith(
              color: Theme.of(context).colorScheme.sightCardTypeColor,
            ),
          ),
        ),

        // Добавить в избранное
        if (cardType == "default")
          Positioned(
            top: 16,
            right: 16,
            child: SvgPicture.asset(
              "assets/icons/Heart.svg",
              width: 24,
              height: 24,
            ),
          ),

        // Кнопка "Удалить из списка"
        if (cardType != "default")
          Positioned(
            top: 16,
            right: 16,
            child: SvgPicture.asset(
              "assets/icons/Delete.svg",
              width: 24,
              height: 24,
            ),
          ),

        // Кнопка "Изменить запланированное время посещения"
        if (cardType == "toVisit")
          Positioned(
            top: 16,
            right: 56,
            child: SvgPicture.asset(
              "assets/icons/Calendar.svg",
              width: 24,
              height: 24,
            ),
          ),

        // Кнопка "Поделиться"
        if (cardType == "visited")
          Positioned(
            top: 16,
            right: 56,
            child: SvgPicture.asset(
              "assets/icons/Share.svg",
              width: 24,
              height: 24,
            ),
          ),
      ],
    );
  }
}

class SightCardBody extends StatelessWidget {
  final Sight sight;
  final String cardType;
  const SightCardBody({Key key, this.sight, this.cardType}) : super(key: key);

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
            constraints: BoxConstraints(
              maxWidth: cardType == "default" ? 296 : double.infinity,
            ),
            child: Text(
              sight.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.sightCardTitle.copyWith(
                color: Theme.of(context).textTheme.headline4.color,
              ),
            ),
          ),

          if (cardType != "default")
            const SizedBox(
              height: 2,
            ),

          // Запланированная дата
          if (cardType == "toVisit")
            Container(
              height: 28,
              child: Text(
                AppTextStrings.scheduledDate,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.sightCardScheduledDate.copyWith(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
            ),

          // Цель достигнута
          if (cardType == "visited")
            Container(
              height: 28,
              child: Text(
                AppTextStrings.goalAchieved,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.sightCardGoalAchieved.copyWith(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
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
              style: AppTextStyles.sightCardWorkingTime.copyWith(
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
