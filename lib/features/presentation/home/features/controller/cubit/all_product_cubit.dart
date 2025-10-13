import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app2/core/data/services/all_product.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';

part 'all_product_state.dart';

class AllProductCubit extends Cubit<AllProductCubitState> {
  final AllProductService allProductService;

  AllProductCubit({required this.allProductService})
    : super(AllProductCubitInitial());
  List<AllProductModel> allProducts = [];
  List<AllProductModel> clothesProducts = [];
  List<AllProductModel> saleProducts = [];
  Future<void> fetchAllProduct() async {
    emit(AllProductCubitLoading());
    try {
      allProducts = await allProductService.getAllProduct();
      clothesProducts = allProducts
          .where(
            (product) =>
                product.categoryName.toLowerCase().contains('clothing'),
          )
          .toList();
      saleProducts = allProducts
          .where((products) => products.discountPercentage > 0)
          .toList();

      emit(AllProductCubitSuccess(products: allProducts));
    } catch (e) {
      emit(AllProductCubitFailure(errMessage: e.toString()));
    }
  }
}
