import 'package:places/data/model/app_state.dart';
import 'package:places/data/redux/action/places_search_action.dart';
import 'package:places/data/redux/state/places_search_state.dart';
import 'package:redux/redux.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, LoadSearchPlacesAction>(loadSearchPlacesReducer),
  TypedReducer<AppState, SearchResultsAction>(searchResultsReducer),
  TypedReducer<AppState, SearchErrorAction>(searchErrorReducer),
]);

/// When loading places.
AppState loadSearchPlacesReducer(
    AppState state, LoadSearchPlacesAction action) {
  return state.cloneWith(searchState: SearchLoadingState());
}

/// On error while loading places.
AppState searchErrorReducer(AppState state, SearchErrorAction action) {
  return state.cloneWith(searchState: SearchErrorState());
}

/// Upon successful loading of places.
AppState searchResultsReducer(AppState state, SearchResultsAction action) {
  return state.cloneWith(searchState: SearchDataState(action.places));
}
