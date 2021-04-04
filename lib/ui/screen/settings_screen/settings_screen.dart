import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/screen/settings_screen/settings_wm.dart';
import 'package:places/ui/widgets/app_bars/app_bar_mini.dart';
import 'package:places/ui/widgets/app_bars/app_bottom_navigation_bar.dart';
import 'package:relation/relation.dart';

/// Screen with application settings.
class SettingsScreen extends CoreMwwmWidget {
  const SettingsScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  }) : super(widgetModelBuilder: widgetModelBuilder ?? SettingsWidgetModel);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends WidgetState<SettingsWidgetModel> {
  @override
  Widget build(BuildContext context) {
    /// Follow the current theme

    return Container(
      child: Scaffold(
        bottomNavigationBar: AppBottomNavigationBar(currentPageIndex: 3),
        body: Column(
          children: [
            AppBarMini(
              title: AppTextStrings.settingsScreenTitle,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App theme switcher
                  EntityStateBuilder<bool>(
                    streamedState: wm.isDarkMode,
                    child: (context, isDarkMode) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          AppTextStrings.settingsScreenEnableDarkTheme,
                          style: AppTextStyles.settingsScreenEnableDarkTheme
                              .copyWith(
                            color: Theme.of(context).textTheme.headline5.color,
                          ),
                        ),
                        trailing: CupertinoSwitch(
                          value: isDarkMode,
                          onChanged: (_) => wm.onUpdateThemeAction(),
                          activeColor: Theme.of(context).accentColor,
                          trackColor: Theme.of(context).disabledColor,
                        ),
                      );
                    },
                  ),

                  _divider(context),

                  // "Watch tutorial" button
                  ListTile(
                    onTap: () => wm.onClickOnboardingButtonAction(),
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      AppTextStrings.settingsScreenWatchTutorial,
                      style: AppTextStyles.settingsScreenWatchTutorial.copyWith(
                        color: Theme.of(context).textTheme.headline5.color,
                      ),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: SvgPicture.asset(
                        AppIcons.info,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  _divider(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _divider(context) {
  return Divider(
    color: Theme.of(context).disabledColor,
    indent: 0,
    endIndent: 0,
    height: 1,
  );
}
