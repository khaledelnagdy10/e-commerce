import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag%20cubit/bag_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/bag_info_body.dart';
import 'package:store_app2/features/presentation/bag/features/view/submit_order_view.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';

class BagView extends StatefulWidget {
  const BagView({super.key});

  @override
  State<BagView> createState() => _BagViewState();
}

class _BagViewState extends State<BagView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15,
          top: 40,
          bottom: 5,
        ),
        child: BlocBuilder<BagCubit, BagState>(
          builder: (context, state) {
            if (state is BagInitial) {
              return Center(
                child: const Text(
                  'No product Added To Cart',
                  style: Style.textStyleBold24Black,
                ),
              );
            }

            if (state is BagUpdated) {
              if (state.totalPrice == 0) {
                return Center(
                  child: const Text(
                    'No product Added To Cart',
                    style: Style.textStyleBold24Black,
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Bag', style: Style.textStyleBoldHeadLine),
                  Expanded(child: BagInfoBody()),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total amount:', style: Style.textStyle14grey),
                      Text(state.totalPrice.toStringAsFixed(2)),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SubmitOrderView(totalPrice: state.totalPrice),
                          ),
                        );
                      },
                      child: Text('Check Out'),
                    ),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
