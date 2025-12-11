import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app2/core/data/services/api_services/get_category_products.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  CategoryProductCubit({required this.getCategoryProductService})
    : super(CategoryProductInitial());
  final GetCategoryProductService getCategoryProductService;

  Future fetchProductCategory({required String categoryName}) async {
    emit(CategoryProductLoading());
    try {
      final categoryProducts = await getCategoryProductService
          .categoryProductService(category: categoryName);
      emit(CategoryProductSuccess(productsList: categoryProducts));
    } on Exception catch (e) {
      emit(
        CategoryProductFailure(
          errMessage: ErrorModel(errMessage: e.toString()),
        ),
      );
    }
  }
}
