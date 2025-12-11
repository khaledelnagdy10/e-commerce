part of 'my_order_cubit.dart';

sealed class MyOrderCubitState extends Equatable {
  const MyOrderCubitState();

  @override
  List<Object> get props => [];
}

final class MyOrderCubitInitial extends MyOrderCubitState {}

final class MyOrderCubitAdded extends MyOrderCubitState {
  final List<MyOrdersModel> orders;

  const MyOrderCubitAdded({required this.orders});
}

final class MyOrderCubitLoading extends MyOrderCubitState {}

final class MyOrderCubitFailure extends MyOrderCubitState {
  final ErrorModel errMess;

  const MyOrderCubitFailure({required this.errMess});
}
