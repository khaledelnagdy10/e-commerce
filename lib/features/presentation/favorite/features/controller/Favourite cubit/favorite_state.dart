part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

class FavoriteUpdated extends FavoriteState {
  final List<AllProductModel> favoriteList;

  const FavoriteUpdated({required this.favoriteList});

  @override
  List<Object> get props => [favoriteList];
}
