import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';
import 'package:store_app2/features/presentation/profile/widgets/my_orders_details_info_body.dart';

class OrderListTile extends StatefulWidget {
  const OrderListTile({super.key});

  @override
  State<OrderListTile> createState() => _OrderListTileState();
}

class _OrderListTileState extends State<OrderListTile> {
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
      body: BlocBuilder<MyOrderCubit, MyOrderCubitState>(
        builder: (context, state) {
          if (state is MyOrderCubitLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MyOrderCubitAdded) {
            final orderList = state.orders;

            if (orderList.isEmpty) {
              return const Center(child: Text('No Orders Found'));
            }

            return ListView.separated(
              itemCount: state.orders.length,
              itemBuilder: (context, i) {
                final order = orderList[i];
                final formattedDate = DateFormat(
                  'dd/MM/yyyy – HH:mm',
                ).format(order.createdAt);

                return ListTile(
                  title: Text('Order #${orderList.length - i}'),
                  subtitle: Text('Placed on $formattedDate'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyOrdersDetailsInfoBody(order: order),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (_, _) => Divider(),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
