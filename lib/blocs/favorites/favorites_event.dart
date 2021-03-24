import 'package:equatable/equatable.dart';

/// Basic event of the favorites list
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

/// Load start event
class FavoritesLoad extends FavoritesEvent {}
