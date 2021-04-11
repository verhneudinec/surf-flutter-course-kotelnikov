import 'package:places/data/model/search_range.dart';
import 'package:places/res/place_types.dart';

/// The class of the search filter.
/// [searchRange] -search range.
/// [searchTypes] -types of places.
class Filter {
  SearchRange searchRange;
  Map<String, bool> searchTypes;

  Filter({
    this.searchRange,
    this.searchTypes,
  });

  /// Filter with default values
  Filter.empty() {
    searchRange = SearchRange(0, 10000);
    searchTypes = {
      PlaceTypes.hotel: false,
      PlaceTypes.restaurant: false,
      PlaceTypes.particular_place: false,
      PlaceTypes.park: false,
      PlaceTypes.museum: false,
      PlaceTypes.cafe: false,
    };
  }
}
