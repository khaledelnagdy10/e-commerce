import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/widgets/custom_text_form_field.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';
import 'package:store_app2/features/presentation/shop/features/controller/categories_cubit/categories_cubit.dart';
import 'package:store_app2/features/presentation/shop/features/views/product_category/category_products_view.dart';

class SearchCategoryView extends StatefulWidget {
  const SearchCategoryView({super.key});

  @override
  State<SearchCategoryView> createState() => _SearchCategoryViewState();
}

class _SearchCategoryViewState extends State<SearchCategoryView> {
  String searchQuery = '';

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
              onChanged: (category) {
                setState(() {
                  searchQuery = category!;
                });
              },
            ),

            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CategoriesFailure) {
                    return Text(
                      '${ErrorModel(errMessage: state.errMessage.errMessage)}',
                    );
                  }

                  if (state is CategoriesSuccess) {
                    if (searchQuery.isEmpty) {
                      return SizedBox.shrink();
                    }
                    final filteredCategories = state.allCategoriesList
                        .where(
                          (p) => p.name.toLowerCase().contains(
                            searchQuery.toLowerCase(),
                          ),
                        )
                        .toList();
                    if (filteredCategories.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }
                    return Expanded(
                      child: ListView.separated(
                        itemCount: filteredCategories.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CategoryProductView(
                                      categoryName: filteredCategories[i].name,
                                    );
                                  },
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(filteredCategories[i].name),
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
