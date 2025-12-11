import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/features/presentation/shop/features/controller/categories_cubit/categories_cubit.dart';
import 'package:store_app2/features/presentation/shop/features/views/product_category/category_products_view.dart';

class AllCategoriesListViewBuilder extends StatelessWidget {
  const AllCategoriesListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final categories = context.read<CategoriesCubit>().allowedCategories;
        if (state is CategoriesLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CategoriesFailure) {
          return Center(child: Text('Error${state.errMessage}'));
        }

        if (state is CategoriesSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CategoryProductView(
                                categoryName: categories[i],
                              );
                            },
                          ),
                        );
                      },
                      child: Text(categories[i], style: Style.textStyle16Black),
                    ),
                  ),
                  SizedBox(height: 9),
                  Divider(),
                ],
              );
            },
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
