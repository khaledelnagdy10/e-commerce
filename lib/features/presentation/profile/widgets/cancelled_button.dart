import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';

class CancelledButton extends StatefulWidget {
  const CancelledButton({super.key, required this.order});
  final MyOrdersModel order;
  @override
  State<CancelledButton> createState() => _CancelledButtonState();
}

class _CancelledButtonState extends State<CancelledButton> {
  @override
  Widget build(BuildContext context) {
    String orderStatus = widget.order.status;

    return ElevatedButton(
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
            content: Text('Are you sure you want to cancel this order?'),
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
            orderStatus = 'Cancelled';
          });
          await context.read<MyOrderCubit>().updateOrderStatus(
            widget.order.id!,
            'Cancelled',
          );
          widget.order.status = 'Cancelled';
        }
        Navigator.pop(context);
      },
      child: Text('Cancelled', style: TextStyle(color: Colors.black)),
    );
  }
}
