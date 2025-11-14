import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/constants.dart';

class PriceDetails extends StatelessWidget {
  const PriceDetails({super.key, required this.text, required this.price});
  final String text;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: Style.textStyle14grey),
            Text(price.toStringAsFixed(2), style: Style.textStyleBold14Black),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
