import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app2/core/data/services/api_services/all_product_service.dart';
import 'package:store_app2/core/data/services/api_services/get_category_products.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';

part 'all_product_state.dart';

class AllProductCubit extends Cubit<AllProductState> {
  final AllProductService allProductService;

  AllProductCubit({required this.allProductService})
    : super(AllProductCubitInitial());
  List<AllProductModel> allProducts = [];
  List<AllProductModel> clothesProducts = [];
  List<AllProductModel> saleProducts = [];
  List<AllProductModel> menShirts = [];
  List<AllProductModel> menShoes = [];
  List<AllProductModel> menWatches = [];
  List<AllProductModel> womensJewellery = [];

  Future<void> fetchAllProduct() async {
    emit(AllProductCubitLoading());
    try {
      allProducts = await allProductService.getAllProduct();
      menShoes = await GetCategoryProductService().categoryProductService(
        category: "mens-shoes",
      );

      menShirts = await GetCategoryProductService().categoryProductService(
        category: "mens-shirts",
      );

      menWatches = await GetCategoryProductService().categoryProductService(
        category: "mens-watches",
      );

      final womenDresses = await GetCategoryProductService()
          .categoryProductService(category: "womens-dresses");

      final womenShoes = await GetCategoryProductService()
          .categoryProductService(category: "womens-shoes");

      final womenWatches = await GetCategoryProductService()
          .categoryProductService(category: "womens-watches");
      final beauty = await GetCategoryProductService().categoryProductService(
        category: "beauty",
      );

      final skinCare = await GetCategoryProductService().categoryProductService(
        category: "skin-care",
      );

      final sunglasses = await GetCategoryProductService()
          .categoryProductService(category: "sunglasses");
      final tops = await GetCategoryProductService().categoryProductService(
        category: "tops",
      );
      final womensBags = await GetCategoryProductService()
          .categoryProductService(category: "womens-bags");
      womensJewellery = await GetCategoryProductService()
          .categoryProductService(category: "womens-jewellery");

      clothesProducts = [
        ...menShirts,
        ...tops,
        ...womenDresses,
        ...menShoes,

        ...womenShoes,
        ...menWatches,
        ...womenWatches,

        ...womensBags,
        ...womensJewellery,
        ...sunglasses,

        ...beauty,

        ...skinCare,
      ];

      saleProducts = clothesProducts
          .where((products) => products.discountPercentage > 0)
          .toList();

      emit(AllProductCubitSuccess(products: clothesProducts));
    } catch (e) {
      emit(AllProductCubitFailure(errMessage: e.toString()));
    }
  }
}
