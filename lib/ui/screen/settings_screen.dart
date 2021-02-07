import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/models/app_settings.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/widgets/app_bar_mini.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

/// Screen with application settings. Contains
/// switch theme using [themeChanger] from [AppSettings] state using provider.
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = context.watch<AppSettings>().isDarkMode;
    void _changeTheme() {
      context.read<AppSettings>().changeTheme();
    }

    return ChangeNotifierProvider(
      create: (_) => AppSettings(),
      child: Container(
        child: Scaffold(
          bottomNavigationBar: AppBottomNavigationBar(),
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
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        AppTextStrings.settingsScreenEnableDarkTheme,
                        style: AppTextStyles.settingsScreenEnableDarkTheme
                            .copyWith(
                          color: Theme.of(context).textTheme.headline5.color,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        value: _isDarkMode,
                        onChanged: (value) => _changeTheme(),
                        activeColor: Theme.of(context).accentColor,
                        trackColor: Theme.of(context).disabledColor,
                      ),
                    ),

                    _divider(context),
                    // "Watch tutorial" button
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        AppTextStrings.settingsScreenWatchTutorial,
                        style:
                            AppTextStyles.settingsScreenWatchTutorial.copyWith(
                          color: Theme.of(context).textTheme.headline5.color,
                        ),
                      ),
                      trailing: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: SvgPicture.asset(
                          "assets/icons/Info.svg",
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
