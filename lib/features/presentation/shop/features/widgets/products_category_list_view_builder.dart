import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app2/features/presentation/favorite/features/controller/Favourite%20cubit/favorite_cubit.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/bag_info_body.dart';
import 'package:store_app2/features/presentation/shop/features/controller/category_product_cubit/category_product_cubit.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_info.dart';

class ProductsCategoryListViewBuilder extends StatefulWidget {
  const ProductsCategoryListViewBuilder({super.key, required this.sortType});
  final int sortType;
  @override
  State<ProductsCategoryListViewBuilder> createState() =>
      _ProductsCategoryListViewBuilderState();
}

class _ProductsCategoryListViewBuilderState
    extends State<ProductsCategoryListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductCubit, CategoryProductState>(
      builder: (context, state) {
        if (state is CategoryProductLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CategoryProductFailure) {
          return Center(child: Text(state.errMessage.errMessage));
        }

        if (state is CategoryProductSuccess) {
          List<AllProductModel> sortedList = [...state.products];

          if (widget.sortType == 0) {
            sortedList.sort((a, b) => a.price.compareTo(b.price));
          } else {
            sortedList.sort((a, b) => b.price.compareTo(a.price));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              childAspectRatio: 0.57,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: sortedList.length,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, i) {
              final sortedProduct = sortedList[i];
              final bool hasDiscount = sortedProduct.discountPercentage > 0;
              final discountedPrice =
                  sortedProduct.price *
                  (1 - sortedProduct.discountPercentage / 100);

              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ProductInfo(product: sortedProduct);
                    },
                  );
                },
                child: Stack(
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
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.star,
                                size: 14,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text(sortedProduct.rating.toString()),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            sortedProduct.category,
                            style: Style.textStyle11grey,
                          ),
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
                ),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
