import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/text_style.dart';

class productCardWide extends StatelessWidget {
  const productCardWide({super.key, required this.product});

  final AllProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      decoration: BoxDecoration(color: Colors.white),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 150,

            child: Image.network(
              product.images,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3),
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
                      Text("LL", style: Style.textStyle14Black),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 15),
            child: Text(
              "${product.price.toStringAsFixed(2)}\$",
              textAlign: TextAlign.end,
              style: Style.textStyle14Black,
            ),
          ),
        ],
      ),
    );
  }
}
