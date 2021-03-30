import 'package:places/data/redux/action/places_search_action.dart';
import 'package:places/data/redux/state/places_search_state.dart';
import 'package:places/data/repository/filtered_places_repository.dart';
import 'package:redux/redux.dart';

class SearchMiddleware implements MiddlewareClass<SearchState> {
  final FilteredPlaceRepository _searchRepository;

  SearchMiddleware(this._searchRepository);

  @override
  call(Store store, dynamic action, NextDispatcher next) {
    if (action is LoadSearchPlacesAction)
      searchHandler(store: store, searchQuery: action.searchQuery);

    next(action);
  }

  /// Search query handler
  void searchHandler({
    Store store,
    String searchQuery,
  }) {
    _searchRepository.searchPlaces(searchQuery: searchQuery).then(
      (result) {
        store.dispatch(
          SearchResultsAction(result),
        );
      },
    ).onError(
      (error, stackTrace) {
        store.dispatch(
          SearchErrorAction(),
        );
      },
    );
  }
}
