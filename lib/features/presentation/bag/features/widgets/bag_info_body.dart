import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/home/features/controller/cubit/all_product_cubit.dart';

class BagInfoBody extends StatefulWidget {
  final String selectedSize;

  final List<AllProductModel> products;
  const BagInfoBody({
    super.key,
    required this.selectedSize,
    required this.products,
  });

  @override
  State<BagInfoBody> createState() => _BagInfoBodyState();
}

class _BagInfoBodyState extends State<BagInfoBody> {
  int productNum = 1;
  @override
  void initState() {
    context.read<AllProductCubit>().fetchAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 10),
        child: BlocBuilder<AllProductCubit, AllProductCubitState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Bag', style: Style.textStyleBold30Black),

                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (_, _) => Divider(),
                    itemCount: widget.products.length,
                    itemBuilder: (context, i) {
                      final product = widget.products[i];

                      return Container(
                        height: 135,
                        decoration: BoxDecoration(color: Colors.white),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 90,

                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                                height: double.infinity,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                  vertical: 3,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          "color:",
                                          style: Style.textStyle14grey,
                                        ),
                                        Text(
                                          "Black",
                                          style: Style.textStyle14Black,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "Size:",
                                          style: Style.textStyle14grey,
                                        ),
                                        Text(
                                          widget.selectedSize,
                                          style: Style.textStyle14Black,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      children: [
                                        FloatingActionButton(
                                          mini: true,
                                          heroTag: null,
                                          shape: CircleBorder(),
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.grey,
                                          onPressed: () {
                                            setState(() {
                                              productNum > 0 ? productNum-- : 0;
                                            });
                                          },
                                          child: Icon(Icons.remove),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "$productNum",
                                          style: Style.textStyle16Black,
                                        ),
                                        SizedBox(width: 10),
                                        FloatingActionButton(
                                          mini: true,
                                          heroTag: null,
                                          shape: CircleBorder(),
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.grey,
                                          onPressed: () {
                                            setState(() {
                                              productNum++;
                                            });
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                                right: 15,
                              ),
                              child: Text(
                                "${(49.99 * productNum).toStringAsFixed(2)}\$",
                                textAlign: TextAlign.end,
                                style: Style.textStyle14Black,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
