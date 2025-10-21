// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:store_app2/core/utils/models/all_product_model.dart';

part 'bag_state.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagInitial());

  List<AllProductModel> bagProductsList = [];

  void addToBagList(AllProductModel product) {
    if (bagProductsList.contains(product)) {
      null;
    } else {
      bagProductsList.add(product);
    }
    emit(BagUpdated(bagList: List.from(bagProductsList), selectedSize: ''));
  }

  bool isFavorite(AllProductModel product) {
    return bagProductsList.contains(product);
  }
}
