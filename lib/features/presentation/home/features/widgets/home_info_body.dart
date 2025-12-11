import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/widgets/image_assets.dart';
import 'package:store_app2/features/presentation/home/features/controller/cubit/all_product_cubit.dart';
import 'package:store_app2/features/presentation/home/features/view/all_products_view.dart';
import 'package:store_app2/features/presentation/home/features/view/all_sale_product_view.dart';
import 'package:store_app2/features/presentation/home/features/widgets/home_custom_categories_grid.dart';
import 'package:store_app2/features/presentation/home/features/widgets/product_new_list_view_builder.dart';
import 'package:store_app2/features/presentation/home/features/widgets/product_sale_list_view_builder.dart';

class HomeInfoBody extends StatefulWidget {
  const HomeInfoBody({super.key});
  @override
  State<HomeInfoBody> createState() => _HomeInfoBodyState();
}

class _HomeInfoBodyState extends State<HomeInfoBody> {
  @override
  void initState() {
    super.initState();
    context.read<AllProductCubit>().fetchAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: ImageAssets(
                    url: 'assets/images/big_banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  bottom: 100,
                  left: 20,
                  child: Text(
                    'Fashion\nSale',
                    style: Style.textStyleBold30White,
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 20,
                  child: SizedBox(
                    width: 160,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Check'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('New', style: Style.textStyleBoldHeadLine),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AllProductsView(
                              categoryName: 'All Products',
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                Text(
                  'You have never seen it before',
                  style: Style.textStyle12grey,
                ),
              ],
            ),
            BlocBuilder<AllProductCubit, AllProductState>(
              builder: (context, state) {
                if (state is AllProductCubitLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is AllProductCubitSuccess) {
                  final products = context
                      .read<AllProductCubit>()
                      .clothesProducts;

                  return NewProductListViewBuilder(products: products);
                }
                if (state is AllProductCubitFailure) {
                  return Center(child: Text('Error: ${state.errMessage}'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sale', style: Style.textStyleBoldHeadLine),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AllSaleProductsView(
                              categoryName: 'Sale Products',
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                Text('Super sale', style: Style.textStyle12grey),
              ],
            ),
            BlocBuilder<AllProductCubit, AllProductState>(
              builder: (context, state) {
                if (state is AllProductCubitLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is AllProductCubitSuccess) {
                  final saleProducts = context
                      .read<AllProductCubit>()
                      .saleProducts;

                  return SaleProductListViewBuilder(products: saleProducts);
                }
                if (state is AllProductCubitFailure) {
                  return Center(child: Text('Error: ${state.errMessage}'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 10),
            HomeCustomCategoriesGrid(),
          ],
        ),
      ),
    );
  }
}
