import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';

class SubmitOrderInfoBody extends StatefulWidget {
  const SubmitOrderInfoBody({super.key, required this.totalPrice});

  final double totalPrice;
  @override
  State<SubmitOrderInfoBody> createState() => _SubmitOrderInfoBodyState();
}

class _SubmitOrderInfoBodyState extends State<SubmitOrderInfoBody> {
  @override
  Widget build(BuildContext context) {
    final userData = context.read<AuthCubit>().userData;

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
              child: Card(
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
                          InkWell(
                            child: Text(
                              'Change',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(userData['address'], style: Style.textStyle16Black),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order:', style: Style.textStyle14Black),
                Text(" ${widget.totalPrice}\$"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery:', style: Style.textStyle14Black),
                Text(" 20\$"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:', style: Style.textStyle14Black),
                Text(" ${(widget.totalPrice) * 20}\$"),
              ],
            ),
            SizedBox(
              height: 100,
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
