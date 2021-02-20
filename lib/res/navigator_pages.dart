import 'package:places/res/localization.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/mocks.dart';

/// Screens for Navigator
class NavigatorPages {
  // Main application paths
  static final homePage = SightListScreen(sightsData: mocks),
      map = AppTextStrings.bottomNavigationBarLabelMap,
      favorites = VisitingScreen(),
      settings = SettingsScreen();
}
