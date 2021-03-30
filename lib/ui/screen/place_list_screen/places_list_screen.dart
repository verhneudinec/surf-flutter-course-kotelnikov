import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/screen/add_place_screen/add_place_route.dart';
import 'package:places/ui/widgets/app_bars/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/app_bars/flexible_app_bar_delegate.dart';
import 'package:places/ui/widgets/places_list.dart';
import 'package:places/ui/screen/add_place_screen/add_place_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';

/// [PlaceListScreen] - a screen with a list of interesting places.
/// Displays in the header [SliverPersistentHeader] with [FlexibleAppBarDelegate],
/// in the footer [AppBottomNavigationBar] and list of places with [PlaceList].
class PlaceListScreen extends StatefulWidget {
  final List<Place> places;

  const PlaceListScreen({Key key, this.places}) : super(key: key);

  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initStore();
    super.didChangeDependencies();
  }

  void _initStore() async {
    // Initialize PlacesStore

    // Load the list of places
  }

  /// To go to the [AddPlaceScreen] screen
  void _onClickCreateButton() {
    Navigator.of(context).push(
      AddPlaceScreenRoute(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool _isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: _isPortraitOrientation
                  ? const EdgeInsets.all(0.0)
                  : const EdgeInsets.symmetric(horizontal: 16.0),
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height - 138,
                maxWidth: double.infinity,
                child: CustomScrollView(
                  slivers: [
                    /// Flexible header
                    SliverPersistentHeader(
                      delegate: FlexibleAppBarDelegate(
                          isPortraitOrientation: _isPortraitOrientation),
                      pinned: _isPortraitOrientation ? true : false,
                    ),

                    widget.places.isEmpty
                        ? // Display loader
                        SliverToBoxAdapter(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: double.infinity,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        : // Display the places loaded from the API
                        PlaceList(
                            places: widget.places,
                            cardsType: CardTypes.general,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isPortraitOrientation
          ? _createPlaceButton()
          : const SizedBox.shrink(),
      bottomNavigationBar: AppBottomNavigationBar(currentPageIndex: 0),
    );
  }

  /// [_createPlaceButton] - action button for adding a new location in PlaceListScreen
  Widget _createPlaceButton() {
    return ClipRRect(
      borderRadius: AppDecorations.createPlaceButton.borderRadius,
      child: Container(
        width: 177,
        height: 48,
        decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.createPlaceButtonGradient,
        ),
        child: TextButton.icon(
          onPressed: () => _onClickCreateButton(),
          icon: SvgPicture.asset(
            AppIcons.plus,
            width: 24,
            height: 24,
          ),
          label: Text(
            AppTextStrings.createPlaceButton.toUpperCase(),
            style: AppTextStyles.createPlaceButton.copyWith(
              color:
                  Theme.of(context).floatingActionButtonTheme.foregroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
