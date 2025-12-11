import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';
import 'package:store_app2/features/presentation/profile/widgets/my_order_details_info_body.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  void initState() {
    super.initState();
    context.read<MyOrderCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Orders', style: Style.textStyleBoldHeadLine),
            Expanded(
              child: BlocBuilder<MyOrderCubit, MyOrderCubitState>(
                builder: (context, state) {
                  if (state is MyOrderCubitLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is MyOrderCubitAdded) {
                    final orderList = state.orders;

                    if (orderList.isEmpty) {
                      return const Center(child: Text('No Orders Found'));
                    }

                    return ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, i) {
                        state.orders.sort(
                          (a, b) => b.createdAt.compareTo(a.createdAt),
                        );
                        final order = orderList[i];
                        final formattedDate = DateFormat(
                          'dd-MM-yyyy',
                        ).format(order.createdAt);

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MyOrderDetailsInfoBody(order: order),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 170,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order #${orderList.length - i}',
                                          style: Style.textStyleBold16Black,
                                        ),
                                        Text(
                                          formattedDate,
                                          style: Style.textStyle14grey,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Text(
                                          'Tracking number:  ',
                                          style: Style.textStyle14grey,
                                        ),
                                        Text("${order.id}"),
                                      ],
                                    ),
                                    SizedBox(height: 30),

                                    Row(
                                      children: [
                                        Spacer(flex: 1),
                                        Text(
                                          'Units:',
                                          style: Style.textStyle14grey,
                                        ),

                                        Text(
                                          '${order.products.fold<int>(0, (sum, product) => sum + product.quantity)}',
                                        ),
                                        Spacer(flex: 100),
                                        Text(
                                          'Total Amount:  ',
                                          style: Style.textStyle14grey,
                                        ),
                                        Text(
                                          "${order.products.fold<double>(0, (sum, product) => sum + (product.price * product.quantity)).toStringAsFixed(2)}\$",
                                          style: Style.textStyleBold14Black,
                                        ),

                                        Spacer(flex: 1),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Status: ',
                                          style: Style.textStyle14grey,
                                        ),
                                        Text(
                                          order.status,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: order.status == 'Delivered'
                                                ? Colors.green
                                                : order.status == 'Cancelled'
                                                ? Colors.red
                                                : Colors.orange,
                                          ),
                                        ),
                                        SizedBox(width: 80),
                                        Text(
                                          'payment method:',
                                          style: Style.textStyle14grey,
                                        ),
                                        Text(
                                          '\t${order.paymentMethod}',
                                          style: Style.textStyleBold14Black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
