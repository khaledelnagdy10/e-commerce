import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/services/api_services/get_all_categories.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/features/presentation/shop/features/controller/categories_cubit/categories_cubit.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/all_categories_widgets/all_categories_list_view_builder.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/all_categories_widgets/search_category_view.dart';

class AllCategoriesInfoBody extends StatelessWidget {
  const AllCategoriesInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoriesCubit(getAllCategory: GetAllCategoryService())
            ..fetchCategories(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Center(
                child: SizedBox(
                  height: 48,
                  width: 343,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('VIEW ALL ITEMS'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Choose category', style: Style.textStyle14grey),
            ),
            SizedBox(height: 30),
            AllCategoriesListViewBuilder(),
          ],
        ),
      ),
    );
  }
}
