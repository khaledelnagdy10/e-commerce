import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/widgets/error_alert_dialog.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag cubit/bag_cubit.dart';

class AddToCartInfoBody extends StatefulWidget {
  const AddToCartInfoBody({super.key, required this.product});
  final AllProductModel product;

  @override
  State<AddToCartInfoBody> createState() => _AddToCartInfoBodyState();
}

class _AddToCartInfoBodyState extends State<AddToCartInfoBody> {
  // Clothes sizes
  List<String> clothesSizes = ['XS', 'S', 'M', 'L', 'XL', '2XL'];

  // Shoe sizes 39 → 46
  List<String> shoeSizes = List.generate(8, (i) => (39 + i).toString());

  // Colors
  List<String> clothesColors = ["Black", "White", "Red", "Blue", "Green"];
  List<String> mensShoesColors = ["Black", "White", "Red", "Blue", "Green"];

  List<String> menWatchesColors = [
    "Black",
    "White",
    "Grey",
    "Blue",
    "Green",
    "Red",
  ];
  List<String> womenWatchesColors = ["Black", "Pink", "White", "Grey", "Blue"];

  int selectedSize = -1;
  int selectedColor = -1;

  // Category checks
  bool isClothes() {
    return widget.product.category.contains("mens-shirts") ||
        widget.product.category.contains("womens-dresses") ||
        widget.product.category.contains("tops");
  }

  bool isMenWatches() {
    return widget.product.category.contains("mens-watches");
  }

  bool isWomenWatches() {
    return widget.product.category.contains("womens-watches");
  }

  bool isShoes() {
    return widget.product.category.contains("shoes");
  }

  @override
  Widget build(BuildContext context) {
    List<String> sizeList = [];
    List<String> colorList = [];

    // Assign sizes + colors depending on product type
    if (isShoes()) {
      sizeList = shoeSizes;
      colorList = mensShoesColors;
    }

    if (isClothes()) {
      sizeList = clothesSizes;
      colorList = clothesColors;
    }

    if (isMenWatches()) {
      colorList = menWatchesColors;
    }

    if (isWomenWatches()) {
      colorList = womenWatchesColors;
    }

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ===== SIZE SELECTION =====
            if (sizeList.isNotEmpty)
              Text("Select Size", style: Style.textStyleBold20Black),

            const SizedBox(height: 15),

            if (sizeList.isNotEmpty)
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: List.generate(sizeList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedSize = index);
                    },
                    child: Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        color: selectedSize == index
                            ? Colors.red
                            : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          sizeList[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }),
              ),

            const SizedBox(height: 20),

            // ===== COLOR SELECTION =====
            if (colorList.isNotEmpty)
              Column(
                children: [
                  Text("Select Color", style: Style.textStyleBold20Black),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: List.generate(colorList.length, (index) {
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = index),
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            color: selectedColor == index
                                ? Colors.red
                                : Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              colorList[index],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),

            const SizedBox(height: 25),

            // ===== ADD TO CART BUTTON =====
            ElevatedButton(
              onPressed: () {
                // Validate selection before adding
                if (sizeList.isNotEmpty && selectedSize == -1) {
                  showDialog(
                    context: context,
                    builder: (context) => ErrorAlertDialog(
                      warningText: "Please choose a size.",
                      onPressed: () => Navigator.pop(context),
                    ),
                  );
                  return;
                }

                if (colorList.isNotEmpty && selectedColor == -1) {
                  showDialog(
                    context: context,
                    builder: (context) => ErrorAlertDialog(
                      warningText: "Please choose a color.",
                      onPressed: () => Navigator.pop(context),
                    ),
                  );
                  return;
                }

                widget.product.selectedSize = sizeList.isNotEmpty
                    ? sizeList[selectedSize]
                    : null;
                widget.product.selectedColor = colorList.isNotEmpty
                    ? colorList[selectedColor]
                    : null;
                context.read<BagCubit>().addToBag(widget.product);

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 48),
              ),
              child: const Text("ADD TO CART"),
            ),
          ],
        ),
      ),
    );
  }
}
