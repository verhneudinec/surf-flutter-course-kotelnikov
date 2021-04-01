import 'package:places/data/model/search_range.dart';

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
    searchRange = SearchRange(100, 10000);
    searchTypes = {
      "hotel": true,
      "restaurant": true,
      "particular_place": true,
      "park": true,
      "museum": true,
      "cafe": true,
    };
  }
}
