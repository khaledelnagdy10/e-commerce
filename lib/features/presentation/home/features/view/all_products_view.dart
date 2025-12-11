import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/widgets/grid_all_products.dart';
import 'package:store_app2/features/presentation/home/features/controller/cubit/all_product_cubit.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_category_widgets/search_product_view.dart';

class AllProductsView extends StatefulWidget {
  const AllProductsView({super.key, required this.categoryName});
  final String categoryName;
  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  @override
  void initState() {
    super.initState();
    context.read<AllProductCubit>().fetchAllProduct();
    if (widget.categoryName == "Summer Sale") {
      sortType = 3;
    }
  }

  int sortType = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllProductCubit, AllProductState>(
        builder: (context, state) {
          if (state is AllProductCubitLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is AllProductCubitSuccess) {
            final cubit = context.read<AllProductCubit>();

            final products = widget.categoryName == "Men Fashion"
                ? [...cubit.menShirts, ...cubit.menShoes, ...cubit.menWatches]
                : widget.categoryName == "Jewellery"
                ? cubit.womensJewellery
                : cubit.clothesProducts;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 202,
                    child: Material(
                      elevation: 1.5,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.arrow_back_ios),
                                ),
                                SizedBox(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SearchProductView(
                                            categoryName: widget.categoryName,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.search),
                                ),
                              ],
                            ),

                            Text(
                              widget.categoryName,
                              style: Style.textStyleBold24Black,
                            ),
                            Container(
                              color: Colors.grey.shade50,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Sort by',
                                                  style: Style.textStyle20Black,
                                                ),
                                                SizedBox(height: 20),
                                                ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      sortType = 2;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text('Popular'),
                                                ),
                                                ListTile(
                                                  onTap: () {},
                                                  title: Text('Newest'),
                                                ),
                                                ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      sortType = 2;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text(
                                                    'Customer review',
                                                  ),
                                                ),
                                                ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      sortType = 1;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text(
                                                    'Price: highest to low',
                                                  ),
                                                ),
                                                ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      sortType = 0;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text(
                                                    'Price: lowest to high',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.sort_outlined),
                                  ),
                                  Text('Filters'),
                                  SizedBox(width: 80),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        sortType = sortType == 0 ? 1 : 0;
                                      });
                                    },
                                    icon: FaIcon(
                                      sortType == 0
                                          ? FontAwesomeIcons.arrowDown
                                          : FontAwesomeIcons.arrowUp,
                                      size: 20,
                                    ),
                                  ),

                                  sortType == 0
                                      ? Text('Price lowest to highest')
                                      : Text('Price highest to lowest'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridAllProducts(products: products, sortType: sortType),
                ],
              ),
            );
          }
          if (state is AllProductCubitFailure) {
            return Center(child: Text('Error: ${state.errMessage}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
