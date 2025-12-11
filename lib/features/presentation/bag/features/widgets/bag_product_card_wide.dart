import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag%20cubit/bag_cubit.dart';

class BagProductCardWide extends StatefulWidget {
  const BagProductCardWide({super.key, required this.product});
  final AllProductModel product;
  @override
  State<BagProductCardWide> createState() => _BagInfoBodyState();
}

class _BagInfoBodyState extends State<BagProductCardWide> {
  @override
  Widget build(BuildContext context) {
    final bagCubit = context.watch<BagCubit>();
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 120,

                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Container(
                    color: Colors.grey.shade300,
                    child: Image.network(
                      widget.product.images,
                      fit: BoxFit.contain,
                      height: double.infinity,
                    ),
                  ),
                ),
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
                        widget.product.productName,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        widget.product.categoryName,
                        style: Style.textStyle12grey,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text("color:", style: Style.textStyle12grey),
                          Text(
                            widget.product.selectedColor ?? '',
                            style: Style.textStyle14Black,
                          ),
                          SizedBox(width: 20),
                          Text("Size:", style: Style.textStyle12grey),
                          Text(
                            widget.product.selectedSize ?? '',
                            style: Style.textStyle14Black,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 40,
                            child: FloatingActionButton(
                              mini: true,

                              heroTag: 'decrement_${widget.product.id}',

                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.grey,
                              onPressed: () {
                                setState(() {
                                  bagCubit.decrementNumberProduct(
                                    widget.product,
                                  );
                                });
                              },
                              child: Icon(Icons.remove),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "${widget.product.quantity}",
                            style: Style.textStyle16Black,
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            height: 30,
                            width: 40,
                            child: FloatingActionButton(
                              mini: true,
                              heroTag: 'increment_${widget.product.id}',
                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.grey,
                              onPressed: () {
                                setState(() {
                                  bagCubit.incrementNumberProduct(
                                    widget.product,
                                  );
                                });
                              },
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Units:\t${widget.product.quantity.toString()}',
                            style: Style.textStyle14grey,
                          ),

                          Text(
                            "${(widget.product.price * widget.product.quantity).toStringAsFixed(2)}\$",
                            textAlign: TextAlign.end,
                            style: Style.textStyle14Black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 15,
          right: 0,
          child: IconButton(
            onPressed: () {
              context.read<BagCubit>().removeFromBag(widget.product);
            },
            icon: Icon(Icons.delete, size: 25),
          ),
        ),
      ],
    );
  }
}
