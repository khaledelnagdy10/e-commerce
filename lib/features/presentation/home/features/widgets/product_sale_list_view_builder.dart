import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/widgets/add_to_cart_info.dart';
import 'package:store_app2/core/utils/widgets/rating.dart';
import 'package:store_app2/features/presentation/home/features/widgets/product_card.dart';

class SaleProductListViewBuilder extends StatelessWidget {
  const SaleProductListViewBuilder({super.key, required this.products});

  final List<AllProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 22),
      child: SizedBox(
        height: 300,

        child: ListView.builder(
          itemCount: products.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            final product = products[i];
            final discountedPrice =
                product.price * (1 - product.discountPercentage / 100);

            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return AddToCartInfoBody(product: product);
                          },
                        );
                      },
                      child: ProductCard(url: product.images),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ratingStar(product.rating),
                        const SizedBox(width: 4),
                        Text(product.rating.toString()),
                      ],
                    ),
                    Text(
                      product.description,
                      style: Style.textStyle12grey,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.productName,
                      style: Style.textStyleBold16Black,
                    ),
                    Row(
                      children: [
                        Text(
                          product.price.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${discountedPrice.toStringAsFixed(2)}\$',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
