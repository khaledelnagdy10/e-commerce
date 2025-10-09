part of 'all_product_cubit.dart';

@immutable
sealed class AllProductCubitState {}

final class AllProductCubitInitial extends AllProductCubitState {}

final class AllProductCubitLoading extends AllProductCubitState {}

final class AllProductCubitSuccess extends AllProductCubitState {
  final List<AllProductModel> products;

  AllProductCubitSuccess({required this.products});
}

final class AllProductCubitFailure extends AllProductCubitState {
  final String errMessage;

  AllProductCubitFailure({required this.errMessage});
}
