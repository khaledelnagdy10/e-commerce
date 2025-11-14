import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/widgets/image_assets.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/card_order_details.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/price_details.dart';

class SubmitOrderView extends StatefulWidget {
  const SubmitOrderView({super.key, required this.totalPrice});

  final double totalPrice;
  @override
  State<SubmitOrderView> createState() => _SubmitOrderViewState();
}

class _SubmitOrderViewState extends State<SubmitOrderView> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shipping address', style: Style.textStyleBold16Black),
            SizedBox(height: 10),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: CardOrderDetails(),
            ),
            Spacer(flex: 10),
            Text('Delivery method', style: Style.textStyleBold20Black),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageAssets(url: 'assets/images/dhl.png', fit: BoxFit.none),
                ImageAssets(url: 'assets/images/usps.png', fit: BoxFit.none),
              ],
            ),
            Spacer(flex: 1),
            Spacer(flex: 1),
            PriceDetails(text: 'Order', price: widget.totalPrice),
            PriceDetails(text: 'Delivery', price: 20),
            PriceDetails(text: 'Order', price: (widget.totalPrice + 20)),

            SizedBox(height: 10),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('SUBMIT ORDER'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
