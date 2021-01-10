///
/// Экран [VisitingScreen] отображает раздел "Избранное".
/// Выводит список "Посетил" или "Хочу посетить" через DefaultTabController.
/// Для индикации текущего таба используется [TabIndicator].
///

import 'package:flutter/material.dart';
import 'package:places/res/localization.dart';
import 'package:places/ui/widgets/app_bar_mini.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/sight_list.dart';
import 'package:places/ui/widgets/tab_indicator.dart';

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
        body: ListView(
          children: [
            AppBarMini(
              title: AppTextStrings.visitingScreenTitle,
              tabBarIndicator: TabIndicator(
                tabController: tabController,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                // TODO Резиновый размер для TabBarView
              ),
              child: TabBarView(
                controller: tabController,
                children: [
                  SightList(cardType: "toVisit"),
                  SightList(cardType: "visited"),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}
