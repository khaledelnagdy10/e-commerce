import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial()) {
    _initFavorites();
  }
  Future<void> _initFavorites() async {
    await loadFavoritesFromCache();
  }

  List<AllProductModel> favoriteProductsList = [];

  void addToFavoriteList(AllProductModel product) {
    emit(FavoriteLoading());
    if (isFavorite(product)) {
      favoriteProductsList.removeWhere((p) => p.id == product.id);
    } else {
      favoriteProductsList.add(product);
    }
    saveFavoriteToCache();
    emit(FavoriteUpdated(favoriteList: List.from(favoriteProductsList)));
  }

  bool isFavorite(AllProductModel product) {
    return favoriteProductsList.any((p) => p.id == product.id);
  }

  void removeFromFavorites(AllProductModel product) {
    if (isFavorite(product)) {
      favoriteProductsList.removeWhere((p) => p.id == product.id);
      saveFavoriteToCache();
    }
    emit(FavoriteUpdated(favoriteList: List.from(favoriteProductsList)));
  }

  Future<void> saveFavoriteToCache() async {
    final favoriteData = jsonEncode(
      favoriteProductsList.map((product) => product.toJson()).toList(),
    );
    await CacheData.setData(key: 'favorites', value: favoriteData);
  }

  Future<void> loadFavoritesFromCache() async {
    final jsonString = await CacheData.getData(key: 'favorites');
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List jsonList = jsonDecode(jsonString);

        favoriteProductsList = jsonList
            .map((p) => AllProductModel.fromJson(p))
            .toList();

        emit(FavoriteUpdated(favoriteList: favoriteProductsList));
      } catch (e) {
        log('Error loading favorites: $e');
        favoriteProductsList = [];
        emit(FavoriteUpdated(favoriteList: []));
      }
    } else {
      favoriteProductsList = [];
      emit(FavoriteUpdated(favoriteList: []));
    }
  }
}
