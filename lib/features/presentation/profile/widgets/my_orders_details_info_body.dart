import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';
import 'package:store_app2/features/presentation/profile/widgets/my_orders_product_card_wide.dart';

class MyOrdersDetailsInfoBody extends StatelessWidget {
  const MyOrdersDetailsInfoBody({super.key, required this.order});
  final MyOrdersModel order;
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'dd/MM/yyyy – HH:mm',
    ).format(order.createdAt);
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
                    'Order id',

                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' $formattedDate',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ...order.products.map((product) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MyOrdersProductCardWide(product: product),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
