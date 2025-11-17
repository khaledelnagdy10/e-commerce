import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/change_address.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';

class CardOrderDetails extends StatefulWidget {
  const CardOrderDetails({super.key});

  @override
  State<CardOrderDetails> createState() => _CardOrderDetailsState();
}

class _CardOrderDetailsState extends State<CardOrderDetails> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.read<AuthCubit>().userData;

    return BlocBuilder<MyOrderCubit, MyOrderCubitState>(
      builder: (context, state) {
        if (state is MyOrderCubitAdded) {
          final order = state.orders.first;
          return Card(
            margin: EdgeInsets.all(0),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userData['name'],
                        style: Style.textStyle16Black,
                        textAlign: TextAlign.left,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ChangeAddress(order: order);
                            },
                          );
                        },
                        child: Text(
                          'Change',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(order.address!, style: Style.textStyle16Black),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
