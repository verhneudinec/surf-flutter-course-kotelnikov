import 'package:flutter/material.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/ui/widgets/app_bars/app_bar_mini.dart';
import 'package:places/ui/widgets/app_bars/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/places_list.dart';
import 'package:places/ui/widgets/tab_indicator.dart';
import 'package:provider/provider.dart';

///The [VisitingScreen] displays the Favorites section.
///Lists "Visited" or "Want to visit" via DefaultTabController.
///[TabIndicator] is used to indicate the current tab.
///The state is controlled by the [FavoritePlaces] provider
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Place> _favoritePlaces = [];
  List<Place> _visitedPlaces = [];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  /// Function for loading places from [PlacesInteractor]
  void _loadFavorites() {
    context.read<PlacesInteractor>().sortFavoritePlaces();
    List<Place> favoritePlaces =
        context.watch<PlacesInteractor>().getFavoritePlaces;
    List<Place> visitedPlaces =
        context.watch<PlacesInteractor>().getVisitedPlaces;
    setState(() {
      _favoritePlaces = favoritePlaces;
      _visitedPlaces = visitedPlaces;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _loadFavorites();
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: Column(
          children: [
            AppBarMini(
              title: AppTextStrings.visitingScreenTitle,
              tabBarIndicator: TabIndicator(
                tabController: tabController,
              ),
            ),
            const SizedBox(
              height: 24,
            ),

            LimitedBox(
              maxHeight: MediaQuery.of(context).size.height - 290,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: IndexedStack(
                  key: ValueKey(tabController.index),
                  index: tabController.index,
                  children: [
                    CustomScrollView(
                      slivers: [
                        PlaceList(
                          places: _favoritePlaces,
                          cardsType: CardTypes.unvisited,
                        ),
                      ],
                    ),
                    CustomScrollView(
                      slivers: [
                        PlaceList(
                          places: _visitedPlaces,
                          cardsType: CardTypes.visited,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // ConstrainedBox(
            //   constraints: BoxConstraints(
            //     maxHeight: MediaQuery.of(context).size.height,
            //     maxWidth: MediaQuery.of(context).size.width,
            //     // TODO Резиновый размер для TabBarView
            //   ),
            //   child: TabBarView(
            //     controller: tabController,
            //     children: [
            //       PlaceList(cardType: CardTypes.unvisited),
            //       PlaceList(cardType: "visited"),
            //     ],
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(currentPageIndex: 2),
      ),
    );
  }
}
