import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/widgets/error_alert_dialog.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag%20cubit/bag_cubit.dart';

class AddToCartInfoBody extends StatefulWidget {
  const AddToCartInfoBody({super.key, required this.product});
  final AllProductModel product;

  @override
  State<AddToCartInfoBody> createState() => _AddToCartInfoBodyState();
}

class _AddToCartInfoBodyState extends State<AddToCartInfoBody> {
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
                onPressed: () {
                  if (selectedIndex == -1) {
                    showDialog(
                      context: context,
                      builder: (context) => ErrorAlertDialog(
                        warningText:
                            'Please choose a size before adding to cart.',
                        onPressed: () => Navigator.pop(context),
                      ),
                    );
                  } else {
                    context.read<BagCubit>().addToBag(widget.product);
                    Navigator.pop(context);
                  }
                },
                child: Text('ADD TO CART'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
