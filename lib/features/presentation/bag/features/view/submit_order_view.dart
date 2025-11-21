import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/address_model.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/core/utils/widgets/error_alert_dialog.dart';
import 'package:store_app2/core/utils/widgets/image_assets.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag%20cubit/bag_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/card_order_details.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/price_details.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';

class SubmitOrderView extends StatefulWidget {
  const SubmitOrderView({super.key, required this.totalPrice});

  final double totalPrice;
  @override
  State<SubmitOrderView> createState() => _SubmitOrderViewState();
}

class _SubmitOrderViewState extends State<SubmitOrderView> {
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
        title: Text('Checkout', style: Style.textStyleAppBarBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: BlocBuilder<BagCubit, BagState>(
          builder: (context, state) {
            if (state is BagUpdated) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shipping address', style: Style.textStyleBold16Black),
                    SizedBox(height: 10),
                    CardOrderDetails(),
                    SizedBox(height: 30),
                    Text('Delivery method', style: Style.textStyleBold20Black),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageAssets(
                          url: 'assets/images/dhl.png',
                          fit: BoxFit.none,
                        ),
                        ImageAssets(
                          url: 'assets/images/usps.png',
                          fit: BoxFit.none,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    PriceDetails(text: 'Order', price: widget.totalPrice),
                    PriceDetails(text: 'Delivery', price: 20),
                    PriceDetails(
                      text: 'Order',
                      price: (widget.totalPrice + 20),
                    ),

                    SizedBox(height: 10),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final lastOrder = context
                              .read<MyOrderCubit>()
                              .newOrder
                              .last;
                          if (state.bagList.isNotEmpty) {
                            await context.read<AuthCubit>().getUserData();

                            final orderModel = MyOrdersModel(
                              products: state.bagList,
                              createdAt: DateTime.now(),
                              address: lastOrder.address,
                              name: lastOrder.name,
                            );

                            context.read<MyOrderCubit>().addOrder(orderModel);

                            context.read<BagCubit>().submittedOrders();
                            Navigator.pop(context);
                          }
                          if (state.bagList.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => ErrorAlertDialog(
                                warningText: 'Error try Product Already Added',
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          }
                        },
                        child: Text('SUBMIT ORDER'),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
