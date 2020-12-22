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
}
