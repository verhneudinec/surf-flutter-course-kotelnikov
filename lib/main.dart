import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/model/app_state.dart';
import 'package:places/data/redux/middleware/places_search_middleware.dart';
import 'package:places/data/repository/filtered_places_repository.dart';
import 'package:places/data/store/places_store/places_store.dart';
import 'package:places/ui/screen/search_screen_redux_demo.dart';
import 'package:provider/provider.dart';
import 'package:places/ui/view_model/add_place_model.dart';
import 'package:places/res/app_routes.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/map_screen.dart';
import 'package:places/ui/screen/places_list_screen.dart';
import 'package:places/ui/screen/favorites_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/view_model/places_search_model.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/view_model/place_types_model.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:redux/redux.dart';
import 'data/redux/reducer/places_search_reducer.dart';

void main() {
  final store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: [
      SearchMiddleware(
        FilteredPlaceRepository(),
      ),
    ],
  );

  runApp(
    MultiProvider(
      providers: [
        /// ViewModels for UI logic
        ChangeNotifierProvider(create: (_) => PlaceTypesModel()),
        ChangeNotifierProvider(create: (_) => AddPlaceModel()),
        ChangeNotifierProvider(create: (_) => PlacesSearchModel()),

        /// Interactors for the business logic of the application
        ChangeNotifierProvider(create: (_) => SettingsInteractor()),
        ChangeNotifierProvider(create: (_) => PlacesInteractor()),
        ChangeNotifierProvider(create: (_) => PlacesSearchInteractor()),

        /// For MobX demo
        Provider(create: (_) => PlacesStore()),
      ],
      child: App(store: store),
    ),
  );
}

class App extends StatefulWidget {
  final Store<AppState> store;

  const App({Key key, this.store}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    /// Find out the current theme from [SettingsInteractor]
    bool _isDarkMode = context.watch<SettingsInteractor>().isDarkMode;

    /// Run the application
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _isDarkMode ? darkTheme : lightTheme,
        home: PlaceSearchScreenReduxDemo(),
        routes: {
          AppRoutes.home: (BuildContext context) => PlaceListScreen(),
          AppRoutes.map: (BuildContext context) => MapScreen(),
          AppRoutes.favorites: (BuildContext context) => FavoritesScreen(),
          AppRoutes.settings: (BuildContext context) => SettingsScreen(),
        },
      ),
    );
  }
}
