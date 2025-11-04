import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/widgets/favorite_product_card_wide.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag%20cubit/bag_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/bag_product_card_wide.dart';

class MyOrdersDetailsInfoBody extends StatefulWidget {
  const MyOrdersDetailsInfoBody({super.key});

  @override
  State<MyOrdersDetailsInfoBody> createState() =>
      _MyOrdersDetailsInfoBodyState();
}

class _MyOrdersDetailsInfoBodyState extends State<MyOrdersDetailsInfoBody> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserData();
  }

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
                  if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final ordersList =
                      context.watch<AuthCubit>().userData['orders']
                          as List<dynamic>? ??
                      [];

                  if (ordersList.isEmpty) {
                    return Center(
                      heightFactor: 11,
                      child: Text(
                        'No orders Submitted',
                        style: Style.textStyleBoldHeadLine,
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: ordersList.length,
                    itemBuilder: (context, i) {
                      final order = ordersList[i];
                      return BagProductCardWide(product: order);
                    },
                    separatorBuilder: (_, __) => Divider(),
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
