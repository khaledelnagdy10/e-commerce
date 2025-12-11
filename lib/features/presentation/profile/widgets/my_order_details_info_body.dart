import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';
import 'package:store_app2/features/presentation/profile/widgets/cancelled_button.dart';
import 'package:store_app2/features/presentation/profile/widgets/delivered_button.dart';
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
              SizedBox(height: 10),
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
              SizedBox(height: 5),

              Text(
                'Address order:\t${widget.order.address.city} ${widget.order.address.region} ${widget.order.address.region}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              ...widget.order.products.map((product) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MyOrdersProductCardWide(product: product),
                );
              }),

              SizedBox(height: 30),

              widget.order.status == 'Pending'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CancelledButton(order: widget.order),
                        SizedBox(width: 20),
                        DeliveredButton(order: widget.order),
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
