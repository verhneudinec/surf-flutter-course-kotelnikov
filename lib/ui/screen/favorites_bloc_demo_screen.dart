import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favorites/favorites_bloc.dart';
import 'package:places/blocs/favorites/favorites_event.dart';
import 'package:places/blocs/favorites/favorites_state.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/ui/widgets/app_bars/app_bar_mini.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/ui/widgets/places_list.dart';
import 'package:places/ui/widgets/tab_indicator.dart';

///The [VisitingScreen] displays the Favorites section.
///Lists "Visited" or "Want to visit" via DefaultTabController.
///[TabIndicator] is used to indicate the current tab.
///The state is controlled by the [FavoritePlaces] provider
class FavoritesBlockDemoScreen extends StatefulWidget {
  const FavoritesBlockDemoScreen({Key key}) : super(key: key);

  @override
  _FavoritesBlockDemoScreenState createState() =>
      _FavoritesBlockDemoScreenState();
}

class _FavoritesBlockDemoScreenState extends State<FavoritesBlockDemoScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  FavoritesBloc _favoritesBloc;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });

    _favoritesBloc = FavoritesBloc(
      PlaceRepository(),
    )..add(FavoritesLoad());
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
                child: BlocProvider<FavoritesBloc>(
                  create: (_) => _favoritesBloc,
                  child: IndexedStack(
                    key: ValueKey(tabController.index),
                    index: tabController.index,
                    children: [
                      BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (_, state) {
                          if (state is FavoritesLoadingProgress)
                            return CircularProgressIndicator();

                          if (state is FavoritesLoadSuccess)
                            return CustomScrollView(
                              slivers: [
                                PlaceList(
                                  places: state.places,
                                  cardsType: CardTypes.unvisited,
                                ),
                              ],
                            );

                          if (state is FavoritesLoadingFailed)
                            return ErrorStub(
                              icon: AppIcons.error,
                              title: AppTextStrings.dataLoadingErrorTitle,
                              subtitle: AppTextStrings.dataLoadingErrorSubtitle,
                            );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(currentPageIndex: 2),
      ),
    );
  }
}
