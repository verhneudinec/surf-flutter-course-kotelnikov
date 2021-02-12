import 'package:flutter/material.dart';
import 'package:places/res/localization.dart';
import 'package:places/ui/widgets/app_bar_mini.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/sight_list.dart';
import 'package:places/ui/widgets/tab_indicator.dart';
import 'package:places/mocks.dart';
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
    List _visitedSights = context.watch<FavoriteSights>().visitedFavoriteSights;
    List _unvisitedSights =
        context.watch<FavoriteSights>().unvisitedFavoriteSights;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        // appBar: AppBarMini(
        //   title: AppTextStrings.visitingScreenTitle,
        //   tabBarIndicator: TabIndicator(
        //     tabController: tabController,
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBarMini(
                title: AppTextStrings.visitingScreenTitle,
                tabBarIndicator: TabIndicator(
                  tabController: tabController,
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: IndexedStack(
                  key: ValueKey(tabController.index),
                  index: tabController.index,
                  children: [
                    SightList(
                      sights: _unvisitedSights,
                      cardType: "toVisit",
                    ),
                    SightList(
                      sights: _visitedSights,
                      cardType: "visited",
                    ),
                  ],
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
              //       SightList(cardType: "toVisit"),
              //       SightList(cardType: "visited"),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}
