import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag%20cubit/bag_cubit.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/bag_product_card_wide.dart';

class BagInfoBody extends StatelessWidget {
  const BagInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BagCubit, BagState>(
      builder: (context, state) {
        final bagCubit = context.watch<BagCubit>();
        final bagList = bagCubit.bagProductsList;

        if (bagList.isEmpty) {
          return const Center(child: Text('No products in your bag'));
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: bagList.length,
          itemBuilder: (context, i) {
            final product = bagList[i];
            return BagProductCardWide(product: product);
          },
        );
      },
    );
  }
}
