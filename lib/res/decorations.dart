import 'package:flutter/material.dart';

class AppDecorations {
  static final sightCardContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
  );

  static final sightCardContainerWithShadow = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(26, 26, 32, 0.16),
        blurRadius: 16,
        spreadRadius: 0,
        offset: Offset(0, 4),
      ),
    ],
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

  static final bottomSheetBorderRadius = BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      bottomSheetTopRectangleRadius = BorderRadius.all(
        Radius.circular(8),
      );

  static final addPhotoDialog = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
  );

  /// Ползунок галереи в [SightDetails]
  static final galleryIndicator = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  );

  /// Скругление углов для для кнопок [ElevatedButton] и [TextButton]
  static final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  );

  /// Кнопка "Запланировать" для [SightDetails]
  static final planningButton = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  );

  /// Контейнер индикатора табов
  static final tabIndicatorContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(40),
  );

  /// Кнопка таба
  static final tabIndicatorContainerElement = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40),
  );

  static final filterScreenCategoryButton = BoxDecoration(
    borderRadius: BorderRadius.circular(40),
  );

  static final filterScreenTickButton = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
  );

  static final createPlaceButton = BoxDecoration(
    borderRadius: BorderRadius.circular(24),
  );

  static final searchBar = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      searchBarSuffix = BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      );

  static final addSightScreenGalleryPrimaryElement = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      addSightScreenGallerySecondaryElement = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      );

  static final sightSearchScreenSearchListTileImage = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
  );

  static final onboardingPageIndicator = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
  );

  static final appBackButtonRadius = Radius.circular(10),
      appCancelButtonRadius = Radius.circular(40);
}
