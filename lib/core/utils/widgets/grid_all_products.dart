import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/features/presentation/home/features/controller/cubit/all_product_cubit.dart';
import 'package:store_app2/core/utils/widgets/add_to_cart_info.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_category_widgets/product_info.dart';

class GridAllProducts extends StatelessWidget {
  const GridAllProducts({
    super.key,
    required this.products,
    required this.sortType,
  });
  final List<AllProductModel> products;
  final int sortType;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<AllProductCubit, AllProductState>(
        builder: (context, state) {
          if (state is AllProductCubitLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AllProductCubitSuccess) {
            List<AllProductModel> sortedList = [...products];

            if (sortType == 0) {
              sortedList.sort((a, b) => a.price.compareTo(b.price));
            } else if (sortType == 1) {
              sortedList.sort((a, b) => b.price.compareTo(a.price));
            } else if (sortType == 2) {
              sortedList.sort((a, b) => b.rating.compareTo(a.rating));
            } else if (sortType == 3) {
              sortedList.sort(
                (a, b) => b.discountPercentage.compareTo(a.discountPercentage),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 20,
                childAspectRatio: 0.57,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, i) {
                // final products = context
                //     .read<AllProductCubit>()
                //     .clothesProducts;

                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return AddToCartInfoBody(product: sortedList[i]);
                      },
                    );
                  },
                  child: ProductInfo(
                    sortedProduct: sortedList[i],
                    hasDiscount: sortedList[i].discountPercentage > 0,
                    discountedPrice:
                        sortedList[i].price *
                        (1 - sortedList[i].discountPercentage / 100),
                  ),
                );
              },
              itemCount: sortedList.length,
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
