import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
part 'bag_state.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagInitial());

  List<AllProductModel> bagProductsList = [];

  void addToBagList(AllProductModel product) {
    if (!isAddedToCart(product)) {
      bagProductsList.add(product);
    }
    emit(BagUpdated(bagList: List.from(bagProductsList)));
  }

  bool isAddedToCart(AllProductModel product) {
    return bagProductsList.any((p) => p.id == product.id);
  }
}
