import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
part 'bag_state.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagInitial()) {
    _initBag();
  }

  List<AllProductModel> bagProductsList = [];

  List<AllProductModel> submittedOrdersList = [];
  Future<void> _initBag() async {
    await loadBagFromCache();
  }

  double get totalAmount {
    return bagProductsList.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  void addToBag(AllProductModel product) {
    if (!isAddedToBag(product)) {
      bagProductsList.add(product);
    }
    saveProductToCache();
    emit(
      BagUpdated(
        bagList: List.from(bagProductsList),
        totalPrice: totalAmount,
        submittedOrdersList: List.from(submittedOrdersList),
      ),
    );
  }

  void removeFromBag(AllProductModel product) {
    if (isAddedToBag(product)) {
      bagProductsList.remove(product);
    }

    emit(
      BagUpdated(
        bagList: List.from(bagProductsList),
        totalPrice: totalAmount,
        submittedOrdersList: List.from(submittedOrdersList),
      ),
    );
  }

  bool isAddedToBag(AllProductModel product) {
    return bagProductsList.any((p) => p.id == product.id);
  }

  void incrementNumberProduct(AllProductModel product) {
    final index = bagProductsList.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      bagProductsList[index].quantity++;
      emit(
        BagUpdated(
          bagList: List.from(bagProductsList),
          totalPrice: totalAmount,
          submittedOrdersList: List.from(submittedOrdersList),
        ),
      );
    }
  }

  void decrementNumberProduct(AllProductModel product) {
    final index = bagProductsList.indexWhere((p) => p.id == product.id);
    if (index != -1 && bagProductsList[index].quantity > 1) {
      bagProductsList[index].quantity--;
      emit(
        BagUpdated(
          bagList: List.from(bagProductsList),
          totalPrice: totalAmount,
          submittedOrdersList: List.from(submittedOrdersList),
        ),
      );
    }
  }

  void submittedOrders() {
    submittedOrdersList.addAll(bagProductsList);
    bagProductsList.clear();
    emit(
      BagUpdated(
        bagList: List.from(bagProductsList),
        totalPrice: totalAmount,
        submittedOrdersList: List.from(submittedOrdersList),
      ),
    );
  }

  Future<void> saveProductToCache() async {
    final bagData = jsonEncode(
      bagProductsList.map((product) => product.toJson()).toList(),
    );
    await CacheData.setData(key: 'bag', value: bagData);
  }

  Future<void> loadBagFromCache() async {
    final jsonString = await CacheData.getData(key: 'bag');
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List jsonList = jsonDecode(jsonString);

        bagProductsList = jsonList
            .map((p) => AllProductModel.fromJson(p))
            .toList();

        emit(
          BagUpdated(
            bagList: bagProductsList,
            submittedOrdersList: submittedOrdersList,
            totalPrice: totalAmount,
          ),
        );
      } catch (e) {
        bagProductsList = [];
        emit(
          BagUpdated(
            bagList: bagProductsList,
            submittedOrdersList: [],
            totalPrice: totalAmount,
          ),
        );
      }
    } else {
      bagProductsList = [];
      emit(
        BagUpdated(
          bagList: [],
          submittedOrdersList: [],
          totalPrice: totalAmount,
        ),
      );
    }
  }
}
