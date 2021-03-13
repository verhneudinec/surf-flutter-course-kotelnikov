import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_types.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/widgets/app_bars/app_bar_custom.dart';
import 'package:provider/provider.dart';

/// Screen for selecting a seat category.
///Opened when adding place in [AddPlaceScreen].
class SelectingPlaceTypeScreen extends StatefulWidget {
  const SelectingPlaceTypeScreen({Key key}) : super(key: key);

  @override
  _SelectingPlaceTypeScreenState createState() =>
      _SelectingPlaceTypeScreenState();
}

class _SelectingPlaceTypeScreenState extends State<SelectingPlaceTypeScreen> {
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
            AppTextStrings.selectingPlaceTypeScreenSaveButton.toUpperCase(),
            style: AppTextStyles.selectingPlaceTypeScreenSaveButton,
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
      title: AppTextStrings.selectingPlaceTypeScreenTitle,
      backButtonEnabled: true,
    );
  }

  Widget _body() {
    // [_placeTypesData] stores place types from provider [PlaceTypes].
    final _placeTypesData = context.watch<PlaceTypes>().placeTypesData;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          for (int i = 0; i < _placeTypesData.length; i++)
            Column(
              children: [
                _typeButton(
                  text: _placeTypesData[i]["text"],
                ),
                _divider(),
              ],
            ),
        ],
      ),
    );
  }

  // The list item - the category of the place.
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
          style: AppTextStyles.selectingPlaceTypeScreenElement.copyWith(
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
