/// Экран с подробной информацией о месте
/// [SightDetails] содержит в себе шапку [SightDetailsHeader]
/// и тело [SightDetailsBody] с основной информацией о месте

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/widgets/imageLoaderBuilder.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;
  const SightDetails({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
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
            child: Container(
              width: 32,
              height: 32,
              decoration: AppDecorations.goBackButton,
              child: Center(
                child: Image.asset("assets/icons/arrow-left.png"),
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
            decoration: AppDecorations.galleryIndicator,
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
              style: AppTextStyles.sightDetailsTitle,
            ),
          ),

          Row(
            children: [
              // Тип места
              Container(
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  sight.type,
                  style: AppTextStyles.sightDetailsType,
                ),
              ),

              // Время работы места
              Container(
                child: Text(
                  "закрыто до 09:00",
                  style: AppTextStyles.sightDetailsWorkingTime,
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
              style: TextStyle(),
            ),
          ),

          // Кнопка построения маршрута
          Container(
            margin: EdgeInsets.symmetric(vertical: 24),
            width: double.infinity,
            height: 48,
            decoration: AppDecorations.ploteRouteButton,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/go.png",
                  width: 20,
                  height: 22,
                ),
                SizedBox(width: 10),
                Text(
                  AppTextStrings.ploteRouteButton.toUpperCase(),
                  style: AppTextStyles.sightDetailsPloteRouteButton,
                ),
              ],
            ),
          ),

          // Разделитель
          Divider(
            color: Color(0xFFEDEEF0),
          ),

          // Кнопки действий
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Кнопка "Запланировать поход"
              Expanded(
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/calendar.png",
                        width: 22,
                        height: 19,
                      ),
                      SizedBox(width: 9),
                      Text(
                        AppTextStrings.planningButton,
                        style: AppTextStyles.sightDetailsPlanningButton,
                      ),
                    ],
                  ),
                ),
              ),

              // Кнопка "Добавить в избранное"
              Expanded(
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/heart.png",
                        color: AppColors.secondary,
                        width: 20,
                        height: 18,
                      ),
                      SizedBox(width: 10),
                      Text(
                        AppTextStrings.favoritesButton,
                        style: AppTextStyles.sightDetailsFavoritesButton,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
