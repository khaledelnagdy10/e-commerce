import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app2/core/data/services/api_services/get_all_categories.dart';
import 'package:store_app2/core/utils/models/categories_model.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoryService getAllCategory;
  CategoriesCubit({required this.getAllCategory}) : super(CategoriesInitial());
  List<String> allowedCategories = [];
  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final allCategories = await getAllCategory.getAllCategories();
      allowedCategories = [
        "mens-shirts",
        'mens-shoes',
        "mens-watches",
        "womens-dresses",

        "womens-shoes",
        "womens-bags",
        "womens-jewellery",

        "womens-watches",

        "sports-accessories",
        "sunglasses",
      ];

      final filteredCategories = allCategories
          .where((category) => allowedCategories.contains(category.name))
          .toList();
      emit(CategoriesSuccess(allCategoriesList: filteredCategories));
    } catch (e) {
      emit(CategoriesFailure(errMessage: ErrorModel(errMessage: e.toString())));
    }
  }
}
