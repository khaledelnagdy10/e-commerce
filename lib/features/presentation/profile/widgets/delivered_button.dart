import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';

class DeliveredButton extends StatefulWidget {
  const DeliveredButton({super.key, required this.order});
  final MyOrdersModel order;
  @override
  State<DeliveredButton> createState() => _DeliveredButtonState();
}

class _DeliveredButtonState extends State<DeliveredButton> {
  @override
  Widget build(BuildContext context) {
    String orderStatus = widget.order.status;
    return ElevatedButton(
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
            content: Text('Are you sure this order is delivered?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Yes'),
              ),
            ],
          ),
        );

        if (confirm) {
          setState(() {
            orderStatus = 'Delivered';
          });
          await context.read<MyOrderCubit>().updateOrderStatus(
            widget.order.id!,
            'Delivered',
          );
          Navigator.pop(context);
        }
      },
      child: Text('Delivered', style: TextStyle(color: Colors.black)),
    );
  }
}
