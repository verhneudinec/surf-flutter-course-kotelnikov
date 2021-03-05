import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/ui/widgets/app_bars/app_bar_mini.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/sight_list.dart';
import 'package:places/ui/widgets/tab_indicator.dart';
import 'package:places/models/favorite_sights.dart';
import 'package:provider/provider.dart';

///The [VisitingScreen] displays the Favorites section.
///Lists "Visited" or "Want to visit" via DefaultTabController.
///[TabIndicator] is used to indicate the current tab.
///The state is controlled by the [FavoriteSights] provider
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Sight> _visitedSights =
        context.watch<FavoriteSights>().visitedFavoriteSights;
    List<Sight> _unvisitedSights =
        context.watch<FavoriteSights>().unvisitedFavoriteSights;
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
              maxHeight: MediaQuery.of(context).size.height - 238,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: IndexedStack(
                  key: ValueKey(tabController.index),
                  index: tabController.index,
                  children: [
                    CustomScrollView(
                      slivers: [
                        SightList(
                          sights: _unvisitedSights,
                          cardsType: CardTypes.unvisited,
                        ),
                      ],
                    ),
                    CustomScrollView(
                      slivers: [
                        SightList(
                          sights: _visitedSights,
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
            //       SightList(cardType: CardTypes.unvisited),
            //       SightList(cardType: "visited"),
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
