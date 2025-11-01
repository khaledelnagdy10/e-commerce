import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/text_style.dart';
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

        return Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(color: Colors.white),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 90,

                child: Image.network(product.images, fit: BoxFit.cover),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 3,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),

                      Row(
                        children: [
                          Text("color:", style: Style.textStyle14grey),
                          Text("Black", style: Style.textStyle14Black),
                          SizedBox(width: 20),
                          Text("Size:", style: Style.textStyle14grey),
                          Text('XL', style: Style.textStyle14Black),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                context.read<BagCubit>().removeFromBagList(
                                  product,
                                );
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          FloatingActionButton(
                            mini: true,
                            heroTag: 'decrement_${product.id}',

                            shape: CircleBorder(),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            onPressed: () {
                              setState(() {
                                bagCubit.decrementNumberProduct(product);
                              });
                            },
                            child: Icon(Icons.remove),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "${product.quantity}",
                            style: Style.textStyle16Black,
                          ),
                          SizedBox(width: 10),
                          FloatingActionButton(
                            mini: true,
                            heroTag: 'increment_${product.id}',
                            shape: CircleBorder(),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            onPressed: () {
                              setState(() {
                                bagCubit.incrementNumberProduct(product);
                              });
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 15),
                child: Text(
                  "${(product.price * product.quantity).toStringAsFixed(2)}\$",
                  textAlign: TextAlign.end,
                  style: Style.textStyle14Black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
