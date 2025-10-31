import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app2/core/data/services/get_all_category.dart';
import 'package:store_app2/core/utils/models/categories_model.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoryService getAllCategory;
  CategoriesCubit({required this.getAllCategory}) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final allCategories = await getAllCategory.getAllCategory();

      emit(CategoriesSuccess(allCategoriesList: allCategories));
    } catch (e) {
      emit(CategoriesFailure(errMessage: ErrorModel(errMessage: e.toString())));
    }
  }
}
