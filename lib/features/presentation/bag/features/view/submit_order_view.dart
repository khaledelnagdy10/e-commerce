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
import 'package:store_app2/features/presentation/bag/features/widgets/custom_switch.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/price_details.dart';
import 'package:store_app2/features/presentation/profile/controller/my_orders_cubit/my_order_cubit.dart';
import 'package:store_app2/stripe_payment/stripe_manager.dart';

class SubmitOrderView extends StatefulWidget {
  const SubmitOrderView({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  State<SubmitOrderView> createState() => _SubmitOrderViewState();
}

class _SubmitOrderViewState extends State<SubmitOrderView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, dynamic>? updatedAddress;
  late double totalPrice = widget.totalPrice + 20;
  bool visaSwitched = false;
  bool cashSwitched = false;

  int paymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    final userData = context.read<AuthCubit>().userData;
    bool userAddress = userData['address'] == true;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Checkout', style: Style.textStyleAppBarBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: BlocBuilder<BagCubit, BagState>(
          builder: (context, state) {
            if (state is! BagUpdated) return const SizedBox.shrink();

            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shipping address', style: Style.textStyleBold16Black),
                    const SizedBox(height: 20),

                    CardOrderDetails(
                      onAddressChanged: (address) {
                        setState(() {
                          updatedAddress = address;
                        });
                      },
                    ),

                    userAddress == false
                        ? const SizedBox(height: 20)
                        : const SizedBox(height: 20),
                    Text('Payment Method', style: Style.textStyleBold16Black),

                    // VISA OPTION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSwitch(
                          isSwitched: visaSwitched,
                          onChanged: (value) {
                            setState(() {
                              visaSwitched = value;
                              if (value) {
                                cashSwitched = false;
                                paymentMethod = 1;
                              } else {
                                paymentMethod = cashSwitched ? 2 : 0;
                              }
                            });
                          },
                        ),
                        Text("Visa", style: Style.textStyleBold14Black),
                      ],
                    ),

                    const Divider(),

                    // ------------------------------------
                    // CASH OPTION
                    // ------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSwitch(
                          isSwitched: cashSwitched,
                          onChanged: (value) {
                            setState(() {
                              cashSwitched = value;
                              if (value) {
                                visaSwitched = false;
                                paymentMethod = 2;
                              } else {
                                paymentMethod = visaSwitched ? 1 : 0;
                              }
                            });
                          },
                        ),
                        Text('Cash', style: Style.textStyleBold14Black),
                      ],
                    ),

                    const Divider(),
                    SizedBox(height: 35),
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
                    userAddress == false
                        ? const SizedBox(height: 50)
                        : const SizedBox(height: 40),
                    PriceDetails(text: 'Order', price: widget.totalPrice),
                    PriceDetails(text: 'Delivery', price: 20),
                    PriceDetails(text: 'Total', price: totalPrice),

                    userAddress == false
                        ? const SizedBox(height: 20)
                        : const SizedBox(height: 0),
                    // ------------------------------------
                    // SUBMIT BUTTON
                    // ------------------------------------
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await context.read<AuthCubit>().getUserData();
                          final userData = context.read<AuthCubit>().userData;
                          if (paymentMethod == 0) {
                            showDialog(
                              context: context,
                              builder: (_) => ErrorAlertDialog(
                                warningText: "Please select a payment method",
                                onPressed: () => Navigator.pop(context),
                              ),
                            );
                            return;
                          }
                          if (!formKey.currentState!.validate()) return;

                          // VISA PAYMENT DONE HERE ONLY
                          if (paymentMethod == 1) {
                            final success = await PaymentManager.makePayment(
                              (totalPrice).toInt(),
                              "EGP",
                            );

                            if (!success) {
                              visaSwitched = false;
                              showDialog(
                                context: context,
                                builder: (_) => ErrorAlertDialog(
                                  warningText:
                                      "Payment failed or canceled. Try again.",
                                  onPressed: () => Navigator.pop(context),
                                ),
                              );
                              return;
                            }
                          }

                          // ADD ORDER
                          final orderModel = MyOrdersModel(
                            products: state.bagList,
                            createdAt: DateTime.now(),
                            address: AddressModel.fromJson(
                              updatedAddress ?? userData['address'],
                            ),
                            name: userData['name'],
                            paymentMethod: paymentMethod == 1 ? 'Visa' : 'Cash',
                          );

                          context.read<MyOrderCubit>().addOrder(orderModel);
                          context.read<BagCubit>().submittedOrders();

                          Navigator.pop(context);
                        },
                        child: const Text("SUBMIT ORDER"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
