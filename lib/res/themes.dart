import 'package:flutter/material.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/decorations.dart';

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
  splashColor: lmSecondaryColor.withOpacity(0.5),
  textTheme: TextTheme(
    headline1: TextStyle(
      // appBarTitle
      color: lmMainColor,
    ),
    headline2: TextStyle(
      // sightDetails
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
    headline6: TextStyle(
      // cardTitle; categoryTitle
      color: lmSecondaryColor,
    ),
    bodyText1: TextStyle(
      // text
      color: lmSecondaryColor,
    ),
    bodyText2: TextStyle(
      /// тип места в [SightDetails]; текст иконки в категории
      color: lmSecondaryColor,
    ),
    subtitle1: TextStyle(
      color: lmSecondary2Color,
      // подзаголовок в карточке места; подсказка в слайдере категорий
    ),
    subtitle2: TextStyle(
      color: lmGreenColor,
      // подзаголовок; дата достигнута
    ),
    caption: TextStyle(
      // время работы
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
      // sightDetails
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
      // тип места
      color: lmSecondary2Color,
    ),
    subtitle1: TextStyle(
      color: dmSecondary2Color,
      // подзаголовок в карточке места
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
);

extension ComponentsColor on ColorScheme {
  bool isLightTheme() => brightness == Brightness.light ? true : false;

  Color get sightCardTypeColor => whiteColor;
  Color get categoryTickColor => whiteColor;
  Color get testColor => isLightTheme() ? lmRedColor : dmGreenColor;
}
