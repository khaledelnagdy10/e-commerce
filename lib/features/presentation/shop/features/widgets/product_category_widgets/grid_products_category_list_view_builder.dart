import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/features/presentation/shop/features/controller/category_product_cubit/category_product_cubit.dart';
import 'package:store_app2/core/utils/widgets/add_to_cart_info.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_category_widgets/product_info.dart';

class GridProductsCategoryListViewBuilder extends StatefulWidget {
  const GridProductsCategoryListViewBuilder({
    super.key,
    required this.sortType,
  });
  final int sortType;
  @override
  State<GridProductsCategoryListViewBuilder> createState() =>
      _GridProductsCategoryListViewBuilderState();
}

class _GridProductsCategoryListViewBuilderState
    extends State<GridProductsCategoryListViewBuilder> {
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
          List<AllProductModel> sortedList = [...state.productsList];

          if (widget.sortType == 0) {
            sortedList.sort((a, b) => a.price.compareTo(b.price));
          }
          if (widget.sortType == 1) {
            sortedList.sort((a, b) => b.price.compareTo(a.price));
          }
          if (widget.sortType == 2) {
            sortedList.sort((a, b) => b.rating.compareTo(a.rating));
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
                      return AddToCartInfoBody(product: sortedProduct);
                    },
                  );
                },
                child: ProductInfo(
                  sortedProduct: sortedProduct,
                  hasDiscount: hasDiscount,
                  discountedPrice: discountedPrice,
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
