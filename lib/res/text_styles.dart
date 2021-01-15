import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles({Key key, BuildContext context});

  ///
  /// Основные стили
  ///

  /// [_largeTitle] - fontSize: 32
  static const _largeTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.13,
  );

  /// [_title] - fontSize: 24
  static const _title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  /// [_subtitle] - fontSize: 18
  static const _subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.34,
  );

  /// [_text] - fontSize: 16
  static const _text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
  );

  /// [_small] - fontSize: 14
  static const _small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.285,
  );

  /// [_smallBold] - fontSize: 14
  static const _smallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.29,
  );

  /// [_superSmall] - fontSize: 12
  static const _superSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.34,
  );

  /// [_button] - fontSize: 14
  static const _button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    height: 1.29,
    letterSpacing: 0.03,
  );

  ///
  /// Стили приложения
  ///

  static final appBarTitle = _largeTitle, //
      appBarMiniTitle = _subtitle;

  // Карточка места
  static final sightCardTitle = _text,
      sightCardScheduledDate = _small,
      sightCardGoalAchieved = _small,
      sightCardType = _smallBold,
      sightCardDescription = _small,
      sightCardWorkingTime = _small;

  // Страница с описанием места
  static final sightDetailsTitle = _title,
      sightDetailsType = _smallBold,
      sightDetailsWorkingTime = _small;

  static final sightDetailsDescription = _small,
      sightDetailsPloteRouteButton = _button,
      sightDetailsPlanningButton = _small,
      sightDetailsFavoritesButton = _small;

  // Страница "Избранное"
  static final visitingScreenActiveTab = _smallBold, //
      visitingScreenInactiveTab = _smallBold;

  // Блок "Ничего не найдено"
  static final emptyPageTitle = _subtitle, //
      emptyPageSubtitle = _small;
}
