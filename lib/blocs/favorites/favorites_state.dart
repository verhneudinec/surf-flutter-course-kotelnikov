import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

/// Basic state of the favorites list
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

/// The state of the loading status
class FavoritesLoadingProgress extends FavoritesState {}

/// The state of the loaded data
class FavoritesLoadSuccess extends FavoritesState {
  final List<Place> places;

  FavoritesLoadSuccess(this.places);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'FavoritesLoadSuccess: {places: $places}';
}

/// Loading error state
class FavoritesLoadingFailed extends FavoritesState {}
