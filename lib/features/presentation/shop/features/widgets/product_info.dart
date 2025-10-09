import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/text_style.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  List sizes = ['XS', 'S', 'M', 'L', 'XL', '2Xl'];
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select size', style: Style.textStyleBold20Black),
            SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(sizes.length, (index) {
                bool isSelected = index == selectedIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: 105,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected == true ? Colors.red : Colors.white,
                      border: Border.all(color: Colors.grey),

                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(sizes[index], style: Style.textStyle16Black),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.grey.shade300),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text('Size info', style: Style.textStyle20Black),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 13),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 25),

            SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('ADD TO CART'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
