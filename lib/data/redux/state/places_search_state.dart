import 'package:places/data/model/place.dart';

/// Basic class
abstract class SearchState {}

/// Initial state
class SearchInitialState implements SearchState {}

/// State of loading places
class SearchLoadingState implements SearchState {}

/// Error state while loading places
class SearchErrorState implements SearchState {}

/// State with successfully loaded data
class SearchDataState implements SearchState {
  final List<Place> results;

  SearchDataState(this.results);
}
