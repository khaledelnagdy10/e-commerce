import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';
import 'package:store_app2/features/presentation/profile/widgets/my_orders_product_card_wide.dart';

class MyOrderDetailsInfoBody extends StatefulWidget {
  MyOrderDetailsInfoBody({super.key, required this.order});
  final MyOrdersModel order;

  @override
  State<MyOrderDetailsInfoBody> createState() => _MyOrderDetailsInfoBodyState();
}

class _MyOrderDetailsInfoBodyState extends State<MyOrderDetailsInfoBody> {
  @override
  Widget build(BuildContext context) {
    String orderStatus = widget.order.status;
    final formattedDate = DateFormat(
      'dd/MM/yyyy – HH:mm',
    ).format(widget.order.createdAt);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Id: ${widget.order.id}',

                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' $formattedDate',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ...widget.order.products.map((product) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MyOrdersProductCardWide(product: product),
                );
              }),

              widget.order.status == 'Pending'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orderStatus == 'Cancelled'
                                ? Colors.red
                                : Colors.grey[100],
                          ),
                          onPressed: () async {
                            bool confirm = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Confirm'),
                                content: Text(
                                  'Are you sure you want to cancel this order?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text('Yes'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm) {
                              setState(() {
                                orderStatus = 'Cancelled';
                              });
                              await context
                                  .read<MyOrderCubit>()
                                  .updateOrderStatus(
                                    widget.order.id!,
                                    'Cancelled',
                                  );
                              widget.order.status = 'Cancelled';
                            }
                          },
                          child: Text(
                            'Cancelled',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orderStatus == 'Delivered'
                                ? Colors.green
                                : Colors.grey[100],
                          ),
                          onPressed: () async {
                            bool confirm = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Confirm'),
                                content: Text(
                                  'Are you sure this order is delivered?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text('Yes'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm) {
                              setState(() {
                                orderStatus = 'Delivered';
                              });
                              await context
                                  .read<MyOrderCubit>()
                                  .updateOrderStatus(
                                    widget.order.id!,
                                    'Delivered',
                                  );
                              Navigator.pop(context, 'Delivered');
                            }
                          },
                          child: Text(
                            'Delivered',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
