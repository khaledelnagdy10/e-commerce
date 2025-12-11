import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';

class MyOrdersProductCardWide extends StatefulWidget {
  const MyOrdersProductCardWide({super.key, required this.product});
  final AllProductModel product;
  @override
  State<MyOrdersProductCardWide> createState() => _BagInfoBodyState();
}

class _BagInfoBodyState extends State<MyOrdersProductCardWide> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.product.categoryName,
                    style: Style.textStyle12grey,
                  ),
                  SizedBox(height: 10),
                  if ((widget.product.selectedColor == null ||
                          widget.product.selectedColor!.isEmpty) &&
                      (widget.product.selectedSize == null ||
                          widget.product.selectedSize!.isEmpty))
                    SizedBox.shrink()
                  else
                    Row(
                      children: [
                        if (widget.product.selectedColor != null &&
                            widget.product.selectedColor!.isNotEmpty) ...[
                          Text("Color: ", style: Style.textStyle12grey),
                          Text(
                            widget.product.selectedColor!,
                            style: Style.textStyle14Black,
                          ),
                          SizedBox(width: 20),
                        ],

                        if (widget.product.selectedSize != null &&
                            widget.product.selectedSize!.isNotEmpty) ...[
                          Text("Size: ", style: Style.textStyle12grey),
                          Text(
                            widget.product.selectedSize!,
                            style: Style.textStyle14Black,
                          ),
                        ],
                      ],
                    ),

                  SizedBox(height: 20),
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
    );
  }
}
