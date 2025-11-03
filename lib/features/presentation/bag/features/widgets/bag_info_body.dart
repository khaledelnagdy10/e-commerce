import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/widgets/product_card_wide.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag%20cubit/bag_cubit.dart';

class BagInfoBody extends StatefulWidget {
  const BagInfoBody({super.key});

  @override
  State<BagInfoBody> createState() => _BagInfoBodyState();
}

class _BagInfoBodyState extends State<BagInfoBody> {
  @override
  Widget build(BuildContext context) {
    final bagCubit = context.watch<BagCubit>();
    final bagList = bagCubit.bagProductsList;
    return ListView.separated(
      separatorBuilder: (_, _) => Divider(),

      itemCount: bagList.length,
      itemBuilder: (context, i) {
        final product = bagList[i];

        return Stack(
          alignment: AlignmentGeometry.topRight,
          children: [
            ProductCardWide(product: product),
            Positioned(
              top: 15,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    context.read<BagCubit>().removeFromBag(product);
                  });
                },
                icon: Icon(Icons.delete, size: 25),
              ),
            ),
          ],
        );
      },
    );
  }
}
