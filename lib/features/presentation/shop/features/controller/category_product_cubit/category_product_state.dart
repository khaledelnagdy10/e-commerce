part of 'category_product_cubit.dart';

@immutable
sealed class CategoryProductState {}

final class CategoryProductInitial extends CategoryProductState {}

final class CategoryProductLoading extends CategoryProductState {}

final class CategoryProductSuccess extends CategoryProductState {
  final List<AllProductModel> productsList;

  CategoryProductSuccess({required this.productsList});
}

final class CategoryProductFailure extends CategoryProductState {
  final ErrorModel errMessage;

  CategoryProductFailure({required this.errMessage});
}
