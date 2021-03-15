import 'package:flutter/material.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/app_bars/flexible_app_bar_delegate.dart';
import 'package:places/ui/widgets/places_list.dart';
import 'package:places/ui/screen/add_place_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:provider/provider.dart';

/// [PlaceListScreen] - a screen with a list of interesting places.
/// Displays in the header [SliverPersistentHeader] with [FlexibleAppBarDelegate],
/// in the footer [AppBottomNavigationBar] and list of places with [PlaceList].
class PlaceListScreen extends StatefulWidget {
  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  bool _isPlaceListLoading = true;

  /// To go to the [AddPlaceScreen] screen
  void _onClickCreateButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlaceScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initPlaces();
  }

  void _initPlaces() async {
    await context.read<PlacesInteractor>().loadPlaces();
    setState(() {
      _isPlaceListLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Place> places = context.watch<PlacesInteractor>().places;
    final bool _isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;
    bool _searchFieldIsNotEmpty =
        context.watch<PlacesSearchInteractor>().searchFieldIsNotEmpty;
    List _searchResults = context.watch<PlacesSearchInteractor>().searchResults;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: _isPortraitOrientation
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              /// Flexible header
              SliverPersistentHeader(
                delegate: FlexibleAppBarDelegate(
                    isPortraitOrientation: _isPortraitOrientation),
                pinned: _isPortraitOrientation ? true : false,
              ),

              /// While the places are not loaded - display [CircularProgressIndicator]
              if (_isPlaceListLoading)
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),

              /// Display search results if they exist
              /// or display the data obtained in the constructor [places]
              if (!_isPlaceListLoading)
                PlaceList(
                  places: _searchFieldIsNotEmpty ? _searchResults : places,
                  cardsType: CardTypes.general,
                ),
            ],
          ),
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
