/// Экран с подробной информацией о месте
/// [SightDetails] содержит в себе шапку [SightDetailsHeader]
/// и тело [SightDetailsBody] с основной информацией о месте

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/widgets/imageLoaderBuilder.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;
  const SightDetails({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: 30, // TODO Нижние отступы в приложении
          ),
          child: Column(
            children: [
              SightDetailsHeader(sight: sight),
              SightDetailsBody(sight: sight),
            ],
          ),
        ),
      ),
    );
  }
}

class SightDetailsHeader extends StatelessWidget {
  final Sight sight;
  const SightDetailsHeader({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Фото достопримечательности
        Container(
          width: double.infinity,
          height: 360,
          decoration: AppDecorations.sightCardImageGradient,
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

        // Кнопка "Вернуться назад"
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 12,
            ),
            child: InkWell(
              onTap: () => print("go back button"),
              child: Container(
                width: 32,
                height: 32,
                decoration: AppDecorations.goBackButton.copyWith(
                  color: Theme.of(context).backgroundColor,
                ),
                child: Material(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: Theme.of(context).backgroundColor,
                  child: IconButton(
                    onPressed: () => print("go back button"),
                    icon: SvgPicture.asset(
                      "assets/icons/Arrow.svg",
                      color: Theme.of(context).iconTheme.color,
                    ),
                    iconSize: 24,
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    splashRadius: 18,
                    splashColor: Theme.of(context).splashColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Ползунок галереи
        Positioned(
          left: -8,
          bottom: 0,
          child: Container(
            width: 152,
            height: 7.57,
            decoration: AppDecorations.galleryIndicator.copyWith(
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        )
      ],
    );
  }
}

class SightDetailsBody extends StatelessWidget {
  final Sight sight;
  const SightDetailsBody({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          // Название места
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 24),
            child: Text(
              sight.name,
              maxLines: 2,
              style: AppTextStyles.sightDetailsTitle.copyWith(
                color: Theme.of(context).textTheme.headline2.color,
              ),
            ),
          ),

          Row(
            children: [
              // Тип места
              Container(
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  sight.type,
                  style: AppTextStyles.sightDetailsType.copyWith(
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ),
              ),

              // Время работы места
              Container(
                child: Text(
                  "закрыто до 09:00",
                  style: AppTextStyles.sightDetailsWorkingTime.copyWith(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
              ),
            ],
          ),

          // Описание места
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 24),
            child: Text(
              sight.details,
              style: AppTextStyles.sightDetailsDescription.copyWith(
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
          ),

          // Кнопка построения маршрута
          Container(
            margin: EdgeInsets.symmetric(vertical: 24),
            child: ElevatedButton.icon(
              onPressed: () => print("plote route button"),
              icon: SvgPicture.asset(
                "assets/icons/Go.svg",
                width: 24,
                height: 24,
              ),
              label: Text(
                AppTextStrings.ploteRouteButton.toUpperCase(),
              ),
            ),
          ),

          // Разделитель
          Container(
            margin: EdgeInsets.only(
              bottom: 8,
            ),
            child: Divider(
              color: Theme.of(context).dividerColor,
              height: 0.8,
            ),
          ),

          // Кнопки действий
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Кнопка "Запланировать поход"
              Expanded(
                child: TextButton(
                  onPressed: () => print("plan button"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Calendar.svg",
                        width: 24,
                        height: 24,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: 9),
                      Text(
                        AppTextStrings.planningButton,
                        style:
                            AppTextStyles.sightDetailsPlanningButton.copyWith(
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Кнопка "Добавить в избранное"
              Expanded(
                child: TextButton.icon(
                  onPressed: () => print("to favorites button"),
                  icon: SvgPicture.asset(
                    "assets/icons/Heart.svg",
                    width: 24,
                    height: 24,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: Text(
                    AppTextStrings.favoritesButton,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
