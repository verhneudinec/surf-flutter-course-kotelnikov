import 'package:places/data/model/place.dart';

/// Basic class.
abstract class SearchAction {}

/// Action when loading places.
/// Accepts a search query [searchQuery] as input.
class LoadSearchPlacesAction extends SearchAction {
  final String searchQuery;

  LoadSearchPlacesAction(this.searchQuery);
}

/// Action of the error that occurred.
class SearchErrorAction extends SearchAction {
  SearchErrorAction();
}

/// Action when the data is successfully loaded.
/// Accepts a list of found places [places] as input.
class SearchResultsAction extends SearchAction {
  final List<Place> places;

  SearchResultsAction(this.places);
}
