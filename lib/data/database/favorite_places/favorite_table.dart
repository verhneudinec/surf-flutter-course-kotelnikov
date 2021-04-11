import 'package:moor/moor.dart';

/// Table for storing favorite place
class Favorites extends Table {
  IntColumn get placeId => integer()();
  TextColumn get placeName => text()();
  TextColumn get placeType => text()();
  TextColumn get placeImage => text()();
  RealColumn get placeLat => real()();
  RealColumn get placeLng => real()();
  DateTimeColumn get visitDate => dateTime()();
  BoolColumn get isVisited => boolean()();
}
