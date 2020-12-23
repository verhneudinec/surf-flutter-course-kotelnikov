import 'package:flutter/material.dart';
import 'package:places/res/colors.dart';

class AppDecorations {
  static final sightCardContainer = BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.circular(16),
  );

  static final sightCardImageGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF252849).withOpacity(0.4),
        Color.fromRGBO(59, 62, 91, 0.032),
      ],
    ),
  );

  /// Ползунок галереи в [SightDetails]
  static final galleryIndicator = BoxDecoration(
    color: AppColors.main,
    borderRadius: BorderRadius.circular(10),
  );

  /// Кнопка "Вернуться назад" для [SightDetails]
  static final goBackButton = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(10),
  );

  /// Кнопка "Построить маршрут" для [SightDetails]
  static final ploteRouteButton = BoxDecoration(
    color: AppColors.green,
    borderRadius: BorderRadius.circular(10),
  );

  /// Кнопка "Построить маршрут" для [SightDetails]
  static final planningButton = BoxDecoration(
    color: AppColors.green,
    borderRadius: BorderRadius.circular(10),
  );
}
