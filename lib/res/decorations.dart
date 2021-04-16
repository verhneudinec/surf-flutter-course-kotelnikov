import 'package:flutter/material.dart';

/// App decorations.
/// This file describes the radius of the blocks
/// and sometimes the gradients and backgrounds.
class AppDecorations {
  /// Default shadow
  static final defaultBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      spreadRadius: 0,
      blurRadius: 4,
      offset: Offset(0, 4), // changes position of shadow
    ),
  ];

  /// Place card container in the [PlaceCard] widget
  static final placeCardContainer = BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      placeCardContainerWithShadow = BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(26, 26, 32, 0.16),
            blurRadius: 16,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      placeCardImageGradient = BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF252849).withOpacity(0.4),
            Color.fromRGBO(59, 62, 91, 0.032),
          ],
        ),
      );

  /// Styles for bottom sheet
  static final bottomSheetBorderRadius = BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      bottomSheetTopRectangleRadius = BorderRadius.all(
        Radius.circular(8),
      );

  /// Styles for the modal window for adding a photo
  static final addPhotoDialog = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
  );

  /// Gallery slider in [PlaceDetails]
  static final galleryIndicator = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  );

  /// Rounding corners for [ElevatedButton] and [TextButton] buttons
  static final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  );

  /// Schedule button for [PlaceDetails]
  static final planningButton = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  );

  /// Tabs indicator container
  static final tabIndicatorContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(40),
  );

  /// Tab button
  static final tabIndicatorContainerElement = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40),
  );

  /// Buttons on pages [FilterScreen]
  static final filterScreenCategoryButton = BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      filterScreenTickButton = BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      );

  /// Button to create a place on the main
  static final createPlaceButton = BoxDecoration(
    borderRadius: BorderRadius.circular(24),
  );

  /// Styles for [SearchBar]
  static final searchBar = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      searchBarSuffix = BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      );

  /// Styles for [AddPlaceScreen]
  static final addPlaceScreenGalleryPrimaryElement = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      addPlaceScreenGallerySecondaryElement = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      );

  /// Styles for [PlaceSearchScreen]
  static final placeSearchScreenSearchListTileImage = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
  );

  /// Styles for [OnboardingScreen]
  static final onboardingPageIndicator = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
  );

  /// Styles for the [AppBackButton] widget
  static final appBackButtonRadius = Radius.circular(10),
      appCancelButtonRadius = Radius.circular(40);

  /// Map buttons radius
  static final mapButtonsRadius = BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      mapCicrleButtonDecoration = BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: AppDecorations.defaultBoxShadow,
      );
}
