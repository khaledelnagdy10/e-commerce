part of 'all_product_cubit.dart';

@immutable
sealed class AllProductState {}

final class AllProductCubitInitial extends AllProductState {}

final class AllProductCubitLoading extends AllProductState {}

final class AllProductCubitSuccess extends AllProductState {
  final List<AllProductModel> products;

  AllProductCubitSuccess({required this.products});
}

final class AllProductCubitFailure extends AllProductState {
  final String errMessage;

  AllProductCubitFailure({required this.errMessage});
}
