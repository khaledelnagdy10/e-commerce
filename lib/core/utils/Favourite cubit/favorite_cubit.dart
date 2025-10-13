import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  List<AllProductModel> favoriteProductsList = [];

  void addToFavoriteList(AllProductModel product) {
    if (favoriteProductsList.contains(product)) {
      favoriteProductsList.remove(product);
    } else {
      favoriteProductsList.add(product);
    }
    emit(FavoriteUpdated(favoriteList: List.from(favoriteProductsList)));
  }

  bool isFavorite(AllProductModel product) {
    return favoriteProductsList.contains(product);
  }
}
