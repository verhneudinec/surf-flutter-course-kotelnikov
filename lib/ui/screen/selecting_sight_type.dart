import 'package:flutter/material.dart';
import 'package:places/models/sight_types.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/widgets/app_bars/app_bar_custom.dart';
import 'package:provider/provider.dart';

/// Screen for selecting a seat category.
///Opened when adding sight in [AddSightScreen].
class SelectingSightTypeScreen extends StatefulWidget {
  const SelectingSightTypeScreen({Key key}) : super(key: key);

  @override
  _SelectingSightTypeScreenState createState() =>
      _SelectingSightTypeScreenState();
}

class _SelectingSightTypeScreenState extends State<SelectingSightTypeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _body(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: TextButton(
          onPressed: () => print("save"),
          child: Text(
            AppTextStrings.selectingSightTypeScreenSaveButton.toUpperCase(),
            style: AppTextStyles.selectingSightTypeScreenSaveButton,
          ),
          style: Theme.of(context).elevatedButtonTheme.style.copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).backgroundColor,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).disabledColor,
                ),
              ),
        ),
      ),
    );
  }

  Widget _header() {
    return AppBarCustom(
      title: AppTextStrings.selectingSightTypeScreenTitle,
      backButtonEnabled: true,
    );
  }

  Widget _body() {
    // [_sightTypesData] stores place types from provider [SightTypes].
    final _sightTypesData = context.watch<SightTypes>().sightTypesData;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          for (int i = 0; i < _sightTypesData.length; i++)
            Column(
              children: [
                _typeButton(
                  text: _sightTypesData[i]["text"],
                ),
                _divider(),
              ],
            ),
        ],
      ),
    );
  }

  // The list item - the category of the sight.
  Widget _typeButton({text}) {
    return InkWell(
      onTap: () => {},
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        width: double.infinity,
        child: Text(
          text,
          style: AppTextStyles.selectingSightTypeScreenElement.copyWith(
            color: Theme.of(context).textTheme.headline5.color,
          ),
        ),
      ),
    );
  }

  // Separator between [_typeButton]
  Widget _divider() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Divider(
        color: Theme.of(context).disabledColor,
        indent: 0,
        endIndent: 0,
        height: 1,
      ),
    );
  }
}
