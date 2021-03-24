import 'package:equatable/equatable.dart';
import 'package:places/data/redux/state/places_search_state.dart';

class AppState {
  final SearchState searchState;

  AppState({SearchState searchState})
      : this.searchState = searchState ?? SearchInitialState();

  AppState cloneWith({SearchState searchState}) =>
      AppState(searchState: searchState ?? this.searchState);
}

// class AppState extends Equatable {
//   final SearchState searchState;

//   AppState({SearchState searchState})
//       : this.searchState = searchState ?? SearchInitialState();

//   AppState cloneWith({SearchState searchState}) =>
//       AppState(searchState: searchState ?? this.searchState);

//   @override
//   List<Object> get props => [searchState];
// }
