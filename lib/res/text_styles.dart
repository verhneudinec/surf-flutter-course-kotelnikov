import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles({Key key, BuildContext context});

  ///
  /// Basic styles
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
      sightCardWorkingTime = _small,
      sightCardDismissibleText = _superSmall.copyWith(
        fontWeight: FontWeight.w500,
      );

  // Страница с описанием места
  static final sightDetailsTitle = _title,
      sightDetailsType = _smallBold,
      sightDetailsWorkingTime = _small,
      sightDetailsDescription = _small,
      sightDetailsPloteRouteButton = _button,
      sightDetailsPlanningButton = _small,
      sightDetailsFavoritesButton = _small;

  // Страница "Избранное"
  static final visitingScreenActiveTab = _smallBold, //
      visitingScreenInactiveTab = _smallBold;

  // Блок "Ничего не найдено"
  static final emptyPageTitle = _subtitle, //
      emptyPageSubtitle = _small;

  // Фильтр интересных мест по категориям и отдаленности
  static final filterScreenClearButton = _text,
      fiterScreenTitle = _superSmall,
      fiterScreenCategoryTitle = _superSmall,
      filterScreenSliderTitle = _text,
      filterScreenSliderHint = _text,
      fiterScreenShowButton = _text;

  static final settingsScreenEnableDarkTheme = _text.copyWith(
        fontWeight: FontWeight.w400,
      ),
      settingsScreenWatchTutorial = _text.copyWith(
        fontWeight: FontWeight.w400,
      );

  static final addSightScreenLabel = _superSmall.copyWith(
        fontWeight: FontWeight.w400,
      ),
      addSightScreenHint = _text.copyWith(
        fontWeight: FontWeight.w400,
      ),
      addSightScreenSightFieldText = _text.copyWith(
        fontWeight: FontWeight.w400,
      ),
      addSightScreenSightSpecifyCoordinatesButton = _text.copyWith(
        fontWeight: FontWeight.w500,
      ),
      addSightScreenSightCreateButton = _button;

  static final appBarCustomCancelButton = _text;

  static final selectingSightTypeScreenElement = _text.copyWith(
        fontWeight: FontWeight.w400,
      ),
      selectingSightTypeScreenSaveButton = _button;

  static final createSightButton = _button;

  static final searchBarHintText = _text.copyWith(
    fontWeight: FontWeight.w400,
  );

  static final sightSearchScreenSearchHistoryTitle = _superSmall,
      sightSearchScreenSearchHistoryElement = _text.copyWith(
        fontWeight: FontWeight.w400,
      ),
      sightSearchScreenCleanHistory = _text,
      sightSearchScreenSearchListTileTitle = _text.copyWith(
        fontWeight: FontWeight.w400,
      ),
      sightSearchScreenSearchListTileSubtitle = _small;
}
