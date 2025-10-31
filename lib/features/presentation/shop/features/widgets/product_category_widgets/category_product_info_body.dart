import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_category_widgets/products_category_list_view_builder.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_category_widgets/search_category_view.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_category_widgets/search_product_view.dart';

class CategoryProductInfoBody extends StatefulWidget {
  const CategoryProductInfoBody({super.key, required this.categoryName});
  final String categoryName;
  @override
  State<CategoryProductInfoBody> createState() =>
      _CategoryProductInfoBodyState();
}

class _CategoryProductInfoBodyState extends State<CategoryProductInfoBody> {
  int sortPriceType = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
                                          onTap: () {},
                                          title: Text('Popular'),
                                        ),
                                        ListTile(
                                          onTap: () {},
                                          title: Text('Newest'),
                                        ),
                                        ListTile(
                                          onTap: () {},
                                          title: Text('Customer review'),
                                        ),
                                        ListTile(
                                          onTap: () {},
                                          title: Text('Price: highest to low'),
                                        ),
                                        ListTile(
                                          onTap: () {},
                                          title: Text('Price: lowest to high'),
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
                                sortPriceType = sortPriceType == 0 ? 1 : 0;
                              });
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.arrowsUpDown,
                              size: 20,
                            ),
                          ),

                          sortPriceType == 0
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ProductsCategoryListViewBuilder(sortType: sortPriceType),
          ),
        ],
      ),
    );
  }
}
