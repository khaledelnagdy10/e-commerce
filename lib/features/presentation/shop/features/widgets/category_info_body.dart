import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/product_info.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/products_category_list_view_builder.dart';

class CategoryInfoBody extends StatefulWidget {
  const CategoryInfoBody({super.key});

  @override
  State<CategoryInfoBody> createState() => _CategoryInfoBodyState();
}

class _CategoryInfoBodyState extends State<CategoryInfoBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
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
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),
                        ],
                      ),

                      Text('Category Name', style: Style.textStyleBold30Black),
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
                                            title: Text(
                                              'Price: highest to low',
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {},
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
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.arrowsUpDown,
                                size: 20,
                              ),
                            ),
                            Text('Price lowest to high'),
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
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ProductInfo();
                    },
                  );
                },
                child: ProductsCategoryListViewBuilder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
