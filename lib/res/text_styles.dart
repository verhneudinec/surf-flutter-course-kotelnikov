import 'package:flutter/material.dart';
import 'package:places/res/colors.dart';

class AppTextStyles {
  ///
  /// Основные стили
  ///
  ///
  static const _largeTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
    height: 1.13,
  );

  static const _title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
    height: 1.2,
  );

  static const _subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
    height: 1.34,
  );

  static const _text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
    height: 1.25,
  );

  static const _small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondary,
    height: 1.285,
  );

  static const _smallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
    height: 1.29,
  );

  static const _superSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.inactiveBlack,
    height: 1.34,
  );

  static const _button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.inactiveBlack,
    height: 1.29,
    letterSpacing: 0.03,
  );

  ///
  /// Стили приложения
  ///
  static final appBarTitle = _largeTitle;

  // Карточка места
  static final sightCardTitle = _text.copyWith(
    color: AppColors.secondary,
  );
  static final sightCardType = _smallBold.copyWith(
    color: AppColors.white,
  );
  static final sightCardDescription = _small.copyWith(
    color: AppColors.secondary2,
  );
  static final sightCardWorkingTime = _small.copyWith(
    color: AppColors.secondary2,
  );

  // Страница с описанием места
  static final sightDetailsTitle = _title;

  static final sightDetailsType = _smallBold;

  static final sightDetailsWorkingTime = _small.copyWith(
    color: AppColors.secondary2,
  );

  static final sightDetailsDescription = _small;

  // Другие стили
  static final subtitle = _subtitle;

  static final superSmall = _superSmall;

  static final button = _button;
}
