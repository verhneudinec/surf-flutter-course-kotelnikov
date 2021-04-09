import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/ui/screen/favorites_screen/favorites_wm.dart';
import 'package:places/ui/widgets/app_bars/app_bar_mini.dart';
import 'package:places/ui/widgets/app_bars/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/places_list.dart';
import 'package:places/ui/widgets/tab_indicator.dart';
import 'package:relation/relation.dart';

/// The [FavoritesScreen] displays the Favorites section.
/// Lists "Visited" or "Want to visit" via DefaultTabController.
/// [TabIndicator] is used to indicate the current tab.
class FavoritesScreen extends CoreMwwmWidget {
  const FavoritesScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  }) : super(widgetModelBuilder: widgetModelBuilder ?? FavoritesWidgetModel);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends WidgetState<FavoritesWidgetModel>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    wm.tabController.content(
      TabController(length: 2, vsync: this),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: EntityStateBuilder<TabController>(
          streamedState: wm.tabController,
          child: (context, tabController) {
            return Column(
              children: [
                AppBarMini(
                  title: AppTextStrings.visitingScreenTitle,
                  tabBarIndicator: TabIndicator(
                    tabController: tabController,
                    clickOnTabAction: wm.clickOnTabAction,
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
                        EntityStateBuilder<List<Place>>(
                          streamedState: wm.favoritePlaces,
                          child: (context, favoritePlaces) {
                            return CustomScrollView(
                              slivers: [
                                PlaceList(
                                  places: favoritePlaces,
                                  cardsType: CardTypes.unvisited,
                                  onDeletePlace: wm.onDeleteFromFavoritesAction,
                                ),
                              ],
                            );
                          },
                        ),
                        EntityStateBuilder<List<Place>>(
                            streamedState: wm.visitedPlaces,
                            child: (context, visitedPlaces) {
                              return CustomScrollView(
                                slivers: [
                                  PlaceList(
                                    places: visitedPlaces,
                                    cardsType: CardTypes.visited,
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: AppBottomNavigationBar(currentPageIndex: 2),
      ),
    );
  }
}
