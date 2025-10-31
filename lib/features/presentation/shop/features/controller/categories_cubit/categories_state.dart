part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<CategoriesModel> allCategoriesList;

  CategoriesSuccess({required this.allCategoriesList});
}

final class CategoriesFailure extends CategoriesState {
  final ErrorModel errMessage;

  CategoriesFailure({required this.errMessage});
}
