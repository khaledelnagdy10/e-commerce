// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bag_cubit.dart';

sealed class BagState extends Equatable {
  const BagState();

  @override
  List<Object> get props => [];
}

final class BagInitial extends BagState {}

class BagUpdated extends BagState {
  final List<AllProductModel> bagList;
  final List<AllProductModel> submittedOrdersList;
  final double totalPrice;

  const BagUpdated({
    required this.bagList,
    required this.submittedOrdersList,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [bagList, totalPrice];
}
