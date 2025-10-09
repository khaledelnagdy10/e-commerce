import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';
import 'package:store_app2/core/utils/widgets/image_assets.dart';
import 'package:store_app2/features/presentation/shop/features/controller/category_product_cubit/category_product_cubit.dart';

class ProductsCategoryListViewBuilder extends StatefulWidget {
  ProductsCategoryListViewBuilder({super.key});

  @override
  State<ProductsCategoryListViewBuilder> createState() =>
      _ProductsCategoryListViewBuilderState();
}

class _ProductsCategoryListViewBuilderState
    extends State<ProductsCategoryListViewBuilder> {
  List<bool> favorite = [];

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
          if (favorite.length != state.products.length) {
            favorite = List.generate(state.products.length, (i) => false);
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              childAspectRatio: 0.57,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.products.length,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, i) {
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
                            state.products[i].image,
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
                            Text(state.products[i].rating.toString()),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          state.products[i].category,
                          style: Style.textStyle11grey,
                        ),
                        const SizedBox(height: 1),
                        Text(
                          state.products[i].productName,
                          style: Style.textStyleBold20Black,
                        ),
                        const SizedBox(height: 4),

                        Text(
                          state.products[i].price.toString(),
                          style: Style.textStyleBold16Black,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 170,
                    right: 6,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 15,
                        onPressed: () {
                          setState(() {
                            favorite[i] = !favorite[i];
                          });
                        },
                        icon: Icon(
                          favorite[i] == true
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: favorite[i] == true ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
