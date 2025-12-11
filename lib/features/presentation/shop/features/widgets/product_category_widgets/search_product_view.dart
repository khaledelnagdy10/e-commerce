import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';
import 'package:store_app2/core/utils/widgets/favorite_product_card_wide.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/bag_product_card_wide.dart';
import 'package:store_app2/features/presentation/shop/features/controller/category_product_cubit/category_product_cubit.dart';
import 'package:store_app2/core/utils/widgets/add_to_cart_info.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_category_widgets/product_info.dart';

class SearchProductView extends StatefulWidget {
  const SearchProductView({super.key, required this.categoryName});
  final String categoryName;
  @override
  State<SearchProductView> createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView> {
  String searchQuery = '';
  @override
  void initState() {
    super.initState();
    context.read<CategoryProductCubit>().fetchProductCategory(
      categoryName: widget.categoryName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            CustomTextFormField(
              title: 'Enter product ',
              onChanged: (product) {
                setState(() {
                  searchQuery = product!;
                });
              },
            ),

            Expanded(
              child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
                builder: (context, state) {
                  if (state is CategoryProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CategoryProductFailure) {
                    return Text(
                      '${ErrorModel(errMessage: state.errMessage.errMessage)}',
                    );
                  }

                  if (state is CategoryProductSuccess) {
                    if (searchQuery.isEmpty) {
                      return SizedBox.shrink();
                    }
                    final filteredProducts = state.productsList
                        .where(
                          (p) => p.title.toLowerCase().contains(
                            searchQuery.toLowerCase(),
                          ),
                        )
                        .toList();
                    if (filteredProducts.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }
                    return Expanded(
                      child: ListView.separated(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, i) {
                          return SizedBox(
                            width: 200,
                            child: GestureDetector(
                              onTap: () {
                                showBottomSheet(
                                  context: context,
                                  builder: (context) => AddToCartInfoBody(
                                    product: filteredProducts[i],
                                  ),
                                );
                              },
                              child: BagProductCardWide(
                                product: filteredProducts[i],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, _) => Divider(),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
