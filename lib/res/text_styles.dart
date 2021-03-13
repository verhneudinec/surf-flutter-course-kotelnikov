import 'package:flutter/material.dart';

/// Styles of application texts
class AppTextStyles {
  AppTextStyles({Key key, BuildContext context});

  /////////////////////
  /// Basic styles ///
  ////////////////////

  /// [_largeTitle] - fontSize: 32, fontWeight: 700
  static const _largeTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.13,
  );

  /// [_title] - fontSize: 24, fontWeight: 700
  static const _title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  /// [_subtitle] - fontSize: 18, fontWeight: 500
  static const _subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.34,
  );

  /// [_text] - fontSize: 16, fontWeight: 500
  static const _text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
  );

  /// [_text] - fontSize: 16, fontWeight: 500
  static const _textWeight400 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.25,
  );

  /// [_small] - fontSize: 14, fontWeight: 400
  static const _small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.285,
  );

  /// [_smallBold] - fontSize: 14, fontWeight: 700
  static const _smallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.29,
  );

  /// [_superSmall] - fontSize: 12, fontWeight: 400
  static const _superSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.34,
  );

  /// [_superSmall] - fontSize: 12
  static const _superSmallWeight500 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.34,
  );

  /// [_button] - fontSize: 14
  static const _button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    height: 1.29,
    letterSpacing: 0.03,
  );

  ///////////////////////////
  /// Application styles ///
  //////////////////////////

  static final appBarTitle = _largeTitle, //
      appBarMiniTitle = _subtitle;

  // Place card
  static final placeCardTitle = _text,
      placeCardScheduledDate = _small,
      placeCardGoalAchieved = _small,
      placeCardType = _smallBold,
      placeCardDescription = _small,
      placeCardWorkingTime = _small,
      placeCardDismissibleText = _superSmallWeight500;

  // A page with a description of the place
  static final placeDetailsTitle = _title,
      placeDetailsType = _smallBold,
      placeDetailsWorkingTime = _small,
      placeDetailsDescription = _small,
      placeDetailsPloteRouteButton = _button,
      placeDetailsPlanningButton = _small,
      placeDetailsFavoritesButton = _small;

  // Favorites page
  static final visitingScreenActiveTab = _smallBold, //
      visitingScreenInactiveTab = _smallBold;

  // Empty page
  static final emptyPageTitle = _subtitle, //
      emptyPageSubtitle = _small;

  // Filter interesting places by category and distance
  static final filterScreenClearButton = _text,
      fiterScreenTitle = _superSmall,
      fiterScreenCategoryTitle = _superSmall,
      filterScreenSliderTitle = _text,
      filterScreenSliderHint = _text,
      fiterScreenShowButton = _text;

  // Settings screen
  static final settingsScreenEnableDarkTheme = _textWeight400,
      settingsScreenWatchTutorial = _textWeight400;

  // Page with adding place
  static final addPlaceScreenLabel = _superSmall,
      addPlaceScreenHint = _textWeight400,
      addPlaceScreenPlaceFieldText = _textWeight400,
      addPlaceScreenPlaceSpecifyCoordinatesButton = _text,
      addPlaceScreenPlaceCreateButton = _button,
      addPlaceScreenPhotoDialogCancelButton = _smallBold,
      addPlaceScreenPhotoDialogTextButtons = _textWeight400;

  // Appbar
  static final appBarCustomCancelButton = _text;

  // Page with the choice of the type of place
  static final selectingPlaceTypeScreenElement = _textWeight400,
      selectingPlaceTypeScreenSaveButton = _button;

  // Button to create a place on the main
  static final createPlaceButton = _button;

  // SearchBar hint
  static final searchBarHintText = _textWeight400;

  // Place search screen
  static final placeSearchScreenSearchHistoryTitle = _superSmall,
      placeSearchScreenSearchHistoryElement = _textWeight400,
      placeSearchScreenCleanHistory = _text,
      placeSearchScreenSearchListTileTitle = _textWeight400,
      placeSearchScreenSearchListTileSubtitle = _small;

  // Onboarding screen
  static final onboardingSkipButton = _text,
      onboardingScreenTitle = _title,
      onboardingScreenSubtitle = _textWeight400,
      onBoardingStartButton = _button;

  static final favoritesScreenDatePickerConfrimButton = _smallBold;
}
