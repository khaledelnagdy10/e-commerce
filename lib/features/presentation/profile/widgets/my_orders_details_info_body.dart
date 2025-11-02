import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/core/utils/widgets/product_card_wide.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag%20cubit/bag_cubit.dart';

class MyOrdersDetailsInfoBody extends StatelessWidget {
  const MyOrdersDetailsInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
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

              BlocBuilder<BagCubit, BagState>(
                builder: (context, state) {
                  if (state is BagUpdated) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('My Orders', style: Style.textStyleBoldHeadLine),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: state.submittedOrdersList.length,
                            itemBuilder: (context, i) {
                              final order = state.submittedOrdersList[i];
                              return ProductCardWide(product: order);
                            },
                            separatorBuilder: (_, _) => Divider(),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                    heightFactor: 11,
                    child: Text(
                      'No orders Submitted',
                      style: Style.textStyleBoldHeadLine,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
