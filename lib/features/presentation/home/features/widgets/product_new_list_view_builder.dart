import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/home/features/widgets/product_card.dart';

class NewProductListViewBuilder extends StatelessWidget {
  const NewProductListViewBuilder({super.key, required this.products});

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
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductCard(url: product.images),
                    const SizedBox(height: 8),
                    Icon(Icons.star_border_outlined),
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
                          '${product.price}\$',
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
