import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/core/utils/widgets/image_assets.dart';

class CustomCategoriesGrid extends StatelessWidget {
  const CustomCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Stack(
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
              child: Text('New Collection', style: Style.textStyleBold30White),
            ),
          ],
        ),

        Row(
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox(
                      width: screenWidth / 2,
                      height: 218,
                      child: ImageAssets(
                        url: 'assets/images/summerSale.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Summer \nsale',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                Stack(
                  children: [
                    SizedBox(
                      height: 195,
                      width: screenWidth / 2,
                      child: ImageAssets(
                        url: "assets/images/blackCategory.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 20,
                      child: Text('Black', style: Style.textStyleBold30White),
                    ),
                  ],
                ),
              ],
            ),

            Stack(
              children: [
                SizedBox(
                  height: 413,
                  width: screenWidth / 2,
                  child: ImageAssets(
                    url: "assets/images/men'sHoodiesCategory.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
