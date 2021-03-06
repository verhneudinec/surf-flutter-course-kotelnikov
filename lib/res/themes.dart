import 'package:flutter/material.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/decorations.dart';

/// ThemeData of application themes
/// [lightTheme] and [darkTheme]

final lightTheme = ThemeData(
  fontFamily: "Roboto",
  primaryColor: lmMainColor,
  accentColor: lmGreenColor,
  cardColor: lmBackgroundColor,
  backgroundColor: lmBackgroundColor,
  scaffoldBackgroundColor: whiteColor,
  bottomAppBarColor: whiteColor,
  disabledColor: lmInactiveBlackColor,
  dividerColor: lmInactiveBlackColor,
  brightness: Brightness.light,
  buttonColor: whiteColor,
  iconTheme: IconThemeData(
    color: lmSecondaryColor,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: whiteColor,
  ),
  splashColor: lmGrayColor.withOpacity(0.5),
  textTheme: TextTheme(
    headline1: TextStyle(
      // appBarTitle
      color: lmMainColor,
    ),
    headline2: TextStyle(
      // placeDetails
      // заголовок OnboardingScreen
      color: lmSecondaryColor,
    ),
    headline3: TextStyle(
      // appBarMiniTitle
      color: lmMainColor,
    ),
    headline4: TextStyle(
      // cardTitle
      color: lmSecondaryColor,
    ),
    headline5: TextStyle(
      // SettingsScreen element
      // SelectingTypeScreen element
      // ListTile in SearchScreen
      color: lmMainColor,
    ),
    headline6: TextStyle(
      // categoryTitle
      color: lmSecondaryColor,
    ),
    bodyText1: TextStyle(
      // text
      color: lmSecondaryColor,
    ),
    bodyText2: TextStyle(
      /// тип места в [PlaceDetails]; текст иконки в категории
      color: lmSecondaryColor,
    ),
    subtitle1: TextStyle(
      color: lmSecondary2Color,
      // подзаголовок в карточке места; подсказка в слайдере категорий
      // подзаголовок OnboardingScreen
    ),
    subtitle2: TextStyle(
      color: lmGreenColor,
      // подзаголовок; дата достигнута
    ),
    caption: TextStyle(
      // время работы
      // элемент истории поиска
      color: lmSecondary2Color,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
      backgroundColor: lmSecondaryColor,
      color: whiteColor,
    ),
    unselectedLabelStyle: TextStyle(
      backgroundColor: lmBackgroundColor,
      color: lmInactiveBlackColor,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: lmGreenColor,
      primary: whiteColor,
      minimumSize: Size(
        double.infinity,
        48,
      ),
      textStyle: TextStyle(
        color: whiteColor,
      ),
      shape: AppDecorations.buttonShape,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: lmSecondaryColor,
      minimumSize: Size(
        double.infinity,
        40,
      ),
      textStyle: TextStyle(
        color: lmSecondaryColor,
      ),
      shape: AppDecorations.buttonShape,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
  dialogBackgroundColor: lmMainColor.withOpacity(0.24),
);

final darkTheme = ThemeData(
  fontFamily: "Roboto",
  primaryColor: dmDarkColor,
  accentColor: dmGreenColor,
  cardColor: dmDarkColor,
  backgroundColor: dmMainColor,
  scaffoldBackgroundColor: dmMainColor,
  bottomAppBarColor: dmMainColor,
  disabledColor: dmInactiveBlackColor,
  dividerColor: dmSecondary2Color,
  brightness: Brightness.dark,
  iconTheme: IconThemeData(
    color: whiteColor,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: whiteColor,
  ),
  splashColor: whiteColor.withOpacity(0.5),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: dmGreenColor,
      primary: whiteColor,
      minimumSize: Size(
        double.infinity,
        48,
      ),
      textStyle: TextStyle(
        color: whiteColor,
      ),
      shape: AppDecorations.buttonShape,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: whiteColor,
      minimumSize: Size(
        double.infinity,
        40,
      ),
      textStyle: TextStyle(
        color: whiteColor,
      ),
      shape: AppDecorations.buttonShape,
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      // appBarTitle
      color: whiteColor,
    ),
    headline2: TextStyle(
      // placeDetails
      color: whiteColor,
    ),
    headline3: TextStyle(
      // appBarMiniTitle
      color: whiteColor,
    ),
    headline4: TextStyle(
      // cardTitle
      color: whiteColor,
    ),
    bodyText1: TextStyle(
      // text
      color: whiteColor,
    ),
    bodyText2: TextStyle(
      // тип места,  кнопка "Отмена" в AppBarCustom
      color: lmSecondary2Color,
    ),
    subtitle1: TextStyle(
      color: dmSecondary2Color,
      // подзаголовок в карточке места
      // подзаголовок в OnboardingScreen
    ),
    subtitle2: TextStyle(
      color: dmGreenColor,
      // подзаголовок, дата достигнута
    ),
    caption: TextStyle(
      // время
      color: dmInactiveBlackColor,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
      backgroundColor: whiteColor,
      color: dmSecondaryColor,
    ),
    unselectedLabelStyle: TextStyle(
      backgroundColor: dmDarkColor,
      color: dmSecondary2Color,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
  dialogBackgroundColor: dmMainColor,
);

/// Additional colors for themes
extension ComponentsColor on ColorScheme {
  /// [isLightTheme] - theme identifier.
  /// If true, light theme is used now.
  /// Otherwise - dark theme.
  bool isLightTheme() => brightness == Brightness.light ? true : false;

  Color get placeCardTypeColor => whiteColor;
  Color get placeCardHeartButtonColor => whiteColor;
  Color get placeCardDismissibleText => whiteColor;
  Color get placeCardDismissibleBackground =>
      isLightTheme() ? lmRedColor : dmRedColor;
  Color get addPlaceScreenPhotoDeleteButton => whiteColor;
  Color get categoryTickColor => whiteColor;
  LinearGradient get createPlaceButtonGradient => isLightTheme()
      ? LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            lmYellowColor,
            lmGreenColor,
          ],
        )
      : LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            dmYellowColor,
            dmGreenColor,
          ],
        );
  Color get splashScreenIconColor => whiteColor;
  LinearGradient get splashScreenBackgroundGradient =>
      isLightTheme() // TODO исправить градиент
          ? LinearGradient(
              begin: Alignment(-2, 0),
              end: Alignment(1, 0),
              colors: [
                lmYellowColor,
                lmGreenColor,
              ],
            )
          : LinearGradient(
              begin: Alignment(-2, 0),
              end: Alignment(1, 0),
              colors: [
                dmYellowColor,
                dmGreenColor,
              ],
            );
}
