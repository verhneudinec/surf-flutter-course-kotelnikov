import 'package:moor/moor.dart';

///Table for storing the history of search queries
class SearchHistorys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get query => text()();
}
