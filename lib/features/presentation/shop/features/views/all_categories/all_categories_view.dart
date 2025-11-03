import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/all_categories_widgets/search_category_view.dart';
import 'package:store_app2/features/presentation/shop/features/widgets/shop_info_body.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Categories', style: Style.textStyleAppBarBlack),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchCategoryView();
                  },
                ),
              );
            },
            icon: Icon(Icons.search, size: 30),
          ),
        ],
      ),

      body: AllCategoriesInfoBody(),
    );
  }
}
