// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SearchHistory extends DataClass implements Insertable<SearchHistory> {
  final int id;
  final String query;
  SearchHistory({@required this.id, @required this.query});
  factory SearchHistory.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return SearchHistory(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      query:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}query']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || query != null) {
      map['query'] = Variable<String>(query);
    }
    return map;
  }

  SearchHistorysCompanion toCompanion(bool nullToAbsent) {
    return SearchHistorysCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      query:
          query == null && nullToAbsent ? const Value.absent() : Value(query),
    );
  }

  factory SearchHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SearchHistory(
      id: serializer.fromJson<int>(json['id']),
      query: serializer.fromJson<String>(json['query']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'query': serializer.toJson<String>(query),
    };
  }

  SearchHistory copyWith({int id, String query}) => SearchHistory(
        id: id ?? this.id,
        query: query ?? this.query,
      );
  @override
  String toString() {
    return (StringBuffer('SearchHistory(')
          ..write('id: $id, ')
          ..write('query: $query')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, query.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SearchHistory &&
          other.id == this.id &&
          other.query == this.query);
}

class SearchHistorysCompanion extends UpdateCompanion<SearchHistory> {
  final Value<int> id;
  final Value<String> query;
  const SearchHistorysCompanion({
    this.id = const Value.absent(),
    this.query = const Value.absent(),
  });
  SearchHistorysCompanion.insert({
    this.id = const Value.absent(),
    @required String query,
  }) : query = Value(query);
  static Insertable<SearchHistory> custom({
    Expression<int> id,
    Expression<String> query,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (query != null) 'query': query,
    });
  }

  SearchHistorysCompanion copyWith({Value<int> id, Value<String> query}) {
    return SearchHistorysCompanion(
      id: id ?? this.id,
      query: query ?? this.query,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistorysCompanion(')
          ..write('id: $id, ')
          ..write('query: $query')
          ..write(')'))
        .toString();
  }
}

class $SearchHistorysTable extends SearchHistorys
    with TableInfo<$SearchHistorysTable, SearchHistory> {
  final GeneratedDatabase _db;
  final String _alias;
  $SearchHistorysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _queryMeta = const VerificationMeta('query');
  GeneratedTextColumn _query;
  @override
  GeneratedTextColumn get query => _query ??= _constructQuery();
  GeneratedTextColumn _constructQuery() {
    return GeneratedTextColumn(
      'query',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, query];
  @override
  $SearchHistorysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'search_historys';
  @override
  final String actualTableName = 'search_historys';
  @override
  VerificationContext validateIntegrity(Insertable<SearchHistory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('query')) {
      context.handle(
          _queryMeta, query.isAcceptableOrUnknown(data['query'], _queryMeta));
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistory map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SearchHistory.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SearchHistorysTable createAlias(String alias) {
    return $SearchHistorysTable(_db, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final int placeId;
  final String placeName;
  final String placeType;
  final String placeImage;
  final double placeLat;
  final double placeLng;
  final DateTime visitDate;
  final bool isVisited;
  Favorite(
      {@required this.placeId,
      @required this.placeName,
      @required this.placeType,
      @required this.placeImage,
      @required this.placeLat,
      @required this.placeLng,
      @required this.visitDate,
      @required this.isVisited});
  factory Favorite.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Favorite(
      placeId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}place_id']),
      placeName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}place_name']),
      placeType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}place_type']),
      placeImage: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}place_image']),
      placeLat: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}place_lat']),
      placeLng: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}place_lng']),
      visitDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}visit_date']),
      isVisited: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_visited']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || placeId != null) {
      map['place_id'] = Variable<int>(placeId);
    }
    if (!nullToAbsent || placeName != null) {
      map['place_name'] = Variable<String>(placeName);
    }
    if (!nullToAbsent || placeType != null) {
      map['place_type'] = Variable<String>(placeType);
    }
    if (!nullToAbsent || placeImage != null) {
      map['place_image'] = Variable<String>(placeImage);
    }
    if (!nullToAbsent || placeLat != null) {
      map['place_lat'] = Variable<double>(placeLat);
    }
    if (!nullToAbsent || placeLng != null) {
      map['place_lng'] = Variable<double>(placeLng);
    }
    if (!nullToAbsent || visitDate != null) {
      map['visit_date'] = Variable<DateTime>(visitDate);
    }
    if (!nullToAbsent || isVisited != null) {
      map['is_visited'] = Variable<bool>(isVisited);
    }
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      placeId: placeId == null && nullToAbsent
          ? const Value.absent()
          : Value(placeId),
      placeName: placeName == null && nullToAbsent
          ? const Value.absent()
          : Value(placeName),
      placeType: placeType == null && nullToAbsent
          ? const Value.absent()
          : Value(placeType),
      placeImage: placeImage == null && nullToAbsent
          ? const Value.absent()
          : Value(placeImage),
      placeLat: placeLat == null && nullToAbsent
          ? const Value.absent()
          : Value(placeLat),
      placeLng: placeLng == null && nullToAbsent
          ? const Value.absent()
          : Value(placeLng),
      visitDate: visitDate == null && nullToAbsent
          ? const Value.absent()
          : Value(visitDate),
      isVisited: isVisited == null && nullToAbsent
          ? const Value.absent()
          : Value(isVisited),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Favorite(
      placeId: serializer.fromJson<int>(json['placeId']),
      placeName: serializer.fromJson<String>(json['placeName']),
      placeType: serializer.fromJson<String>(json['placeType']),
      placeImage: serializer.fromJson<String>(json['placeImage']),
      placeLat: serializer.fromJson<double>(json['placeLat']),
      placeLng: serializer.fromJson<double>(json['placeLng']),
      visitDate: serializer.fromJson<DateTime>(json['visitDate']),
      isVisited: serializer.fromJson<bool>(json['isVisited']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'placeId': serializer.toJson<int>(placeId),
      'placeName': serializer.toJson<String>(placeName),
      'placeType': serializer.toJson<String>(placeType),
      'placeImage': serializer.toJson<String>(placeImage),
      'placeLat': serializer.toJson<double>(placeLat),
      'placeLng': serializer.toJson<double>(placeLng),
      'visitDate': serializer.toJson<DateTime>(visitDate),
      'isVisited': serializer.toJson<bool>(isVisited),
    };
  }

  Favorite copyWith(
          {int placeId,
          String placeName,
          String placeType,
          String placeImage,
          double placeLat,
          double placeLng,
          DateTime visitDate,
          bool isVisited}) =>
      Favorite(
        placeId: placeId ?? this.placeId,
        placeName: placeName ?? this.placeName,
        placeType: placeType ?? this.placeType,
        placeImage: placeImage ?? this.placeImage,
        placeLat: placeLat ?? this.placeLat,
        placeLng: placeLng ?? this.placeLng,
        visitDate: visitDate ?? this.visitDate,
        isVisited: isVisited ?? this.isVisited,
      );
  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('placeId: $placeId, ')
          ..write('placeName: $placeName, ')
          ..write('placeType: $placeType, ')
          ..write('placeImage: $placeImage, ')
          ..write('placeLat: $placeLat, ')
          ..write('placeLng: $placeLng, ')
          ..write('visitDate: $visitDate, ')
          ..write('isVisited: $isVisited')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      placeId.hashCode,
      $mrjc(
          placeName.hashCode,
          $mrjc(
              placeType.hashCode,
              $mrjc(
                  placeImage.hashCode,
                  $mrjc(
                      placeLat.hashCode,
                      $mrjc(placeLng.hashCode,
                          $mrjc(visitDate.hashCode, isVisited.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.placeId == this.placeId &&
          other.placeName == this.placeName &&
          other.placeType == this.placeType &&
          other.placeImage == this.placeImage &&
          other.placeLat == this.placeLat &&
          other.placeLng == this.placeLng &&
          other.visitDate == this.visitDate &&
          other.isVisited == this.isVisited);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> placeId;
  final Value<String> placeName;
  final Value<String> placeType;
  final Value<String> placeImage;
  final Value<double> placeLat;
  final Value<double> placeLng;
  final Value<DateTime> visitDate;
  final Value<bool> isVisited;
  const FavoritesCompanion({
    this.placeId = const Value.absent(),
    this.placeName = const Value.absent(),
    this.placeType = const Value.absent(),
    this.placeImage = const Value.absent(),
    this.placeLat = const Value.absent(),
    this.placeLng = const Value.absent(),
    this.visitDate = const Value.absent(),
    this.isVisited = const Value.absent(),
  });
  FavoritesCompanion.insert({
    @required int placeId,
    @required String placeName,
    @required String placeType,
    @required String placeImage,
    @required double placeLat,
    @required double placeLng,
    @required DateTime visitDate,
    @required bool isVisited,
  })  : placeId = Value(placeId),
        placeName = Value(placeName),
        placeType = Value(placeType),
        placeImage = Value(placeImage),
        placeLat = Value(placeLat),
        placeLng = Value(placeLng),
        visitDate = Value(visitDate),
        isVisited = Value(isVisited);
  static Insertable<Favorite> custom({
    Expression<int> placeId,
    Expression<String> placeName,
    Expression<String> placeType,
    Expression<String> placeImage,
    Expression<double> placeLat,
    Expression<double> placeLng,
    Expression<DateTime> visitDate,
    Expression<bool> isVisited,
  }) {
    return RawValuesInsertable({
      if (placeId != null) 'place_id': placeId,
      if (placeName != null) 'place_name': placeName,
      if (placeType != null) 'place_type': placeType,
      if (placeImage != null) 'place_image': placeImage,
      if (placeLat != null) 'place_lat': placeLat,
      if (placeLng != null) 'place_lng': placeLng,
      if (visitDate != null) 'visit_date': visitDate,
      if (isVisited != null) 'is_visited': isVisited,
    });
  }

  FavoritesCompanion copyWith(
      {Value<int> placeId,
      Value<String> placeName,
      Value<String> placeType,
      Value<String> placeImage,
      Value<double> placeLat,
      Value<double> placeLng,
      Value<DateTime> visitDate,
      Value<bool> isVisited}) {
    return FavoritesCompanion(
      placeId: placeId ?? this.placeId,
      placeName: placeName ?? this.placeName,
      placeType: placeType ?? this.placeType,
      placeImage: placeImage ?? this.placeImage,
      placeLat: placeLat ?? this.placeLat,
      placeLng: placeLng ?? this.placeLng,
      visitDate: visitDate ?? this.visitDate,
      isVisited: isVisited ?? this.isVisited,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (placeName.present) {
      map['place_name'] = Variable<String>(placeName.value);
    }
    if (placeType.present) {
      map['place_type'] = Variable<String>(placeType.value);
    }
    if (placeImage.present) {
      map['place_image'] = Variable<String>(placeImage.value);
    }
    if (placeLat.present) {
      map['place_lat'] = Variable<double>(placeLat.value);
    }
    if (placeLng.present) {
      map['place_lng'] = Variable<double>(placeLng.value);
    }
    if (visitDate.present) {
      map['visit_date'] = Variable<DateTime>(visitDate.value);
    }
    if (isVisited.present) {
      map['is_visited'] = Variable<bool>(isVisited.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('placeId: $placeId, ')
          ..write('placeName: $placeName, ')
          ..write('placeType: $placeType, ')
          ..write('placeImage: $placeImage, ')
          ..write('placeLat: $placeLat, ')
          ..write('placeLng: $placeLng, ')
          ..write('visitDate: $visitDate, ')
          ..write('isVisited: $isVisited')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  final GeneratedDatabase _db;
  final String _alias;
  $FavoritesTable(this._db, [this._alias]);
  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  GeneratedIntColumn _placeId;
  @override
  GeneratedIntColumn get placeId => _placeId ??= _constructPlaceId();
  GeneratedIntColumn _constructPlaceId() {
    return GeneratedIntColumn(
      'place_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _placeNameMeta = const VerificationMeta('placeName');
  GeneratedTextColumn _placeName;
  @override
  GeneratedTextColumn get placeName => _placeName ??= _constructPlaceName();
  GeneratedTextColumn _constructPlaceName() {
    return GeneratedTextColumn(
      'place_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _placeTypeMeta = const VerificationMeta('placeType');
  GeneratedTextColumn _placeType;
  @override
  GeneratedTextColumn get placeType => _placeType ??= _constructPlaceType();
  GeneratedTextColumn _constructPlaceType() {
    return GeneratedTextColumn(
      'place_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _placeImageMeta = const VerificationMeta('placeImage');
  GeneratedTextColumn _placeImage;
  @override
  GeneratedTextColumn get placeImage => _placeImage ??= _constructPlaceImage();
  GeneratedTextColumn _constructPlaceImage() {
    return GeneratedTextColumn(
      'place_image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _placeLatMeta = const VerificationMeta('placeLat');
  GeneratedRealColumn _placeLat;
  @override
  GeneratedRealColumn get placeLat => _placeLat ??= _constructPlaceLat();
  GeneratedRealColumn _constructPlaceLat() {
    return GeneratedRealColumn(
      'place_lat',
      $tableName,
      false,
    );
  }

  final VerificationMeta _placeLngMeta = const VerificationMeta('placeLng');
  GeneratedRealColumn _placeLng;
  @override
  GeneratedRealColumn get placeLng => _placeLng ??= _constructPlaceLng();
  GeneratedRealColumn _constructPlaceLng() {
    return GeneratedRealColumn(
      'place_lng',
      $tableName,
      false,
    );
  }

  final VerificationMeta _visitDateMeta = const VerificationMeta('visitDate');
  GeneratedDateTimeColumn _visitDate;
  @override
  GeneratedDateTimeColumn get visitDate => _visitDate ??= _constructVisitDate();
  GeneratedDateTimeColumn _constructVisitDate() {
    return GeneratedDateTimeColumn(
      'visit_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isVisitedMeta = const VerificationMeta('isVisited');
  GeneratedBoolColumn _isVisited;
  @override
  GeneratedBoolColumn get isVisited => _isVisited ??= _constructIsVisited();
  GeneratedBoolColumn _constructIsVisited() {
    return GeneratedBoolColumn(
      'is_visited',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        placeId,
        placeName,
        placeType,
        placeImage,
        placeLat,
        placeLng,
        visitDate,
        isVisited
      ];
  @override
  $FavoritesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'favorites';
  @override
  final String actualTableName = 'favorites';
  @override
  VerificationContext validateIntegrity(Insertable<Favorite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id'], _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('place_name')) {
      context.handle(_placeNameMeta,
          placeName.isAcceptableOrUnknown(data['place_name'], _placeNameMeta));
    } else if (isInserting) {
      context.missing(_placeNameMeta);
    }
    if (data.containsKey('place_type')) {
      context.handle(_placeTypeMeta,
          placeType.isAcceptableOrUnknown(data['place_type'], _placeTypeMeta));
    } else if (isInserting) {
      context.missing(_placeTypeMeta);
    }
    if (data.containsKey('place_image')) {
      context.handle(
          _placeImageMeta,
          placeImage.isAcceptableOrUnknown(
              data['place_image'], _placeImageMeta));
    } else if (isInserting) {
      context.missing(_placeImageMeta);
    }
    if (data.containsKey('place_lat')) {
      context.handle(_placeLatMeta,
          placeLat.isAcceptableOrUnknown(data['place_lat'], _placeLatMeta));
    } else if (isInserting) {
      context.missing(_placeLatMeta);
    }
    if (data.containsKey('place_lng')) {
      context.handle(_placeLngMeta,
          placeLng.isAcceptableOrUnknown(data['place_lng'], _placeLngMeta));
    } else if (isInserting) {
      context.missing(_placeLngMeta);
    }
    if (data.containsKey('visit_date')) {
      context.handle(_visitDateMeta,
          visitDate.isAcceptableOrUnknown(data['visit_date'], _visitDateMeta));
    } else if (isInserting) {
      context.missing(_visitDateMeta);
    }
    if (data.containsKey('is_visited')) {
      context.handle(_isVisitedMeta,
          isVisited.isAcceptableOrUnknown(data['is_visited'], _isVisitedMeta));
    } else if (isInserting) {
      context.missing(_isVisitedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Favorite map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Favorite.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(_db, alias);
  }
}

abstract class _$AppDB extends GeneratedDatabase {
  _$AppDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SearchHistorysTable _searchHistorys;
  $SearchHistorysTable get searchHistorys =>
      _searchHistorys ??= $SearchHistorysTable(this);
  $FavoritesTable _favorites;
  $FavoritesTable get favorites => _favorites ??= $FavoritesTable(this);
  SearchHistorysDao _searchHistorysDao;
  SearchHistorysDao get searchHistorysDao =>
      _searchHistorysDao ??= SearchHistorysDao(this as AppDB);
  FavoritesDao _favoritesDao;
  FavoritesDao get favoritesDao =>
      _favoritesDao ??= FavoritesDao(this as AppDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [searchHistorys, favorites];
}
