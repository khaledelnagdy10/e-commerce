import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/bag_info_body.dart';

class BagView extends StatelessWidget {
  const BagView({
    super.key,
    required this.selectedSize,
    required this.products,
  });
  final String selectedSize;

  final List<AllProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0),

        child: BagInfoBody(selectedSize: selectedSize, products: products),
      ),
    );
  }
}
