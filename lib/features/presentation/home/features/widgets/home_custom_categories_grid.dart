import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/widgets/image_assets.dart';
import 'package:store_app2/features/presentation/home/features/view/all_products_view.dart';

class HomeCustomCategoriesGrid extends StatelessWidget {
  const HomeCustomCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AllProductsView(categoryName: 'New collection');
                },
              ),
            );
          },
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: ImageAssets(
                  url: 'assets/images/newCollection.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Text(
                  'New Collection',
                  style: Style.textStyleBold30White,
                ),
              ),
            ],
          ),
        ),

        Row(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AllProductsView(categoryName: 'Summer Sale');
                        },
                      ),
                    );
                  },
                  child: SizedBox(
                    width: screenWidth / 2,
                    height: 218,
                    child: ImageAssets(
                      url: 'assets/images/sale.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AllProductsView(categoryName: 'Jewellery');
                        },
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 195,
                        width: screenWidth / 2,
                        child: ImageAssets(
                          url: "assets/images/jellewry.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AllProductsView(categoryName: 'Men Fashion');
                    },
                  ),
                );
              },
              child: Stack(
                children: [
                  SizedBox(
                    height: 413,
                    width: screenWidth / 2,
                    child: ImageAssets(
                      url: "assets/images/menFashion.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
