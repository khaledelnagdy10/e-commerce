import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/constants.dart' show Style;
import 'package:store_app2/core/utils/widgets/rating.dart';
import 'package:store_app2/features/presentation/favorite/features/controller/Favourite%20cubit/favorite_cubit.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.sortedProduct,
    required this.hasDiscount,
    required this.discountedPrice,
  });

  final AllProductModel sortedProduct;
  final bool hasDiscount;
  final double discountedPrice;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  sortedProduct.images,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, size: 50),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ratingStar(sortedProduct.rating),
                  const SizedBox(width: 4),
                  Text(sortedProduct.rating.toString()),
                ],
              ),
              const SizedBox(height: 6),
              Text(sortedProduct.category, style: Style.textStyle12grey),
              const SizedBox(height: 1),
              Text(
                sortedProduct.productName,
                style: Style.textStyleBold20Black,
              ),
              const SizedBox(height: 4),

              hasDiscount
                  ? Row(
                      children: [
                        Text(
                          sortedProduct.price.toStringAsFixed(2),
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
                    )
                  : Text(
                      '${sortedProduct.price.toStringAsFixed(2)}\$',
                      style: TextStyle(color: Colors.red),
                    ),
            ],
          ),
        ),
        BlocSelector<FavoriteCubit, FavoriteState, bool>(
          selector: (state) {
            if (state is FavoriteUpdated) {
              return state.favoriteList.any(
                (item) => item.id == sortedProduct.id,
              );
            }
            return false;
          },
          builder: (context, isFav) {
            return Positioned(
              top: 170,
              right: 6,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 15,
                  onPressed: () {
                    context.read<FavoriteCubit>().addToFavoriteList(
                      sortedProduct,
                    );
                  },
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_outline,
                    color: isFav ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
