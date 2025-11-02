import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
part 'bag_state.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagInitial());

  List<AllProductModel> bagProductsList = [];

  List<AllProductModel> submittedOrdersList = [];
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
}
