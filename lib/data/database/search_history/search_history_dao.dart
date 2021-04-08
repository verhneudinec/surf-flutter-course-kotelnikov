import 'package:moor/moor.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/database/search_history/search_history_table.dart';

part 'search_history_dao.g.dart';

@UseDao(tables: [SearchHistorys])

/// Data access object for [SearchHostorys] table
class SearchHistorysDao extends DatabaseAccessor<AppDB>
    with _$SearchHistorysDaoMixin {
  SearchHistorysDao(AppDB attachedDatabase) : super(attachedDatabase);

  /// Getter to get the entire search history in a list
  Future<List<String>> get searchHistory async {
    final response = await select(searchHistorys).get();
    return response.map((historyItem) => historyItem.query).toList();
  }

  /// Saving the search query in the db
  Future<void> saveSearchQuery(String request) async {
    into(searchHistorys)
      ..insert(
        SearchHistorysCompanion(
          query: Value(request),
        ),
      );
  }

  /// Removing a search query from history
  Future<void> deleteSearchQuery(String request) async {
    delete(searchHistorys)
      ..where(
        (table) => table.query.equals(request),
      )
      ..go();
  }

  /// Clears the entire history of requests
  Future<void> clearSearchHistory() async {
    delete(searchHistorys)..go();
  }
}
