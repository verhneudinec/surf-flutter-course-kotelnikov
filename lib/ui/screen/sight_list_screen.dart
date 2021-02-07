import 'package:flutter/material.dart';
import 'package:places/ui/widgets/app_bar_large_title.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/sight_list.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';

/// [SightListScreen] - a screen with a list of interesting places.
/// Displays in the header [AppBarLargeTitle], in the footer [AppBottomNavigationBar]
/// and list of sights with [SightList].
class SightListScreen extends StatefulWidget {
  SightListScreen({Key key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarLargeTitle(),
            SightList(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ClipRRect(
        borderRadius: AppDecorations.createPlaceButton.borderRadius,
        child: Container(
          width: 177,
          height: 48,
          decoration: BoxDecoration(
            gradient: Theme.of(context).colorScheme.createSightButtonGradient,
          ),
          child: TextButton.icon(
            onPressed: () => print("create"),
            icon: SvgPicture.asset(
              "assets/icons/Plus.svg",
              width: 24,
              height: 24,
            ),
            label: Text(
              AppTextStrings.createSightButton.toUpperCase(),
              style: AppTextStyles.createSightButton.copyWith(
                color:
                    Theme.of(context).floatingActionButtonTheme.foregroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
