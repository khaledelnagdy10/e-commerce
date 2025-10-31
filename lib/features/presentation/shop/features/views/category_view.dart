import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/services/get_category_products.dart';
import 'package:store_app2/features/presentation/shop/features/controller/category_product_cubit/category_product_cubit.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_category_widgets/category_product_info_body.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryProductCubit(
        getCategoryProductService: GetCategoryProductService(),
      )..fetchProductCategory(categoryName: categoryName),
      child: CategoryProductInfoBody(categoryName: categoryName),
    );
  }
}
