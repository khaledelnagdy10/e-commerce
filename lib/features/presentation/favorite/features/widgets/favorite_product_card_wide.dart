import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/features/presentation/favorite/features/controller/Favourite%20cubit/favorite_cubit.dart';

class FavoriteProductCardWide extends StatefulWidget {
  const FavoriteProductCardWide({super.key, required this.product});

  final AllProductModel product;

  @override
  State<FavoriteProductCardWide> createState() => _BagProductCardWideState();
}

class _BagProductCardWideState extends State<FavoriteProductCardWide> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 135,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 120,

                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Container(
                    color: Colors.grey.shade300,
                    child: Image.network(
                      widget.product.images,
                      fit: BoxFit.contain,
                      height: double.infinity,
                    ),
                  ),
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
                        widget.product.productName,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        widget.product.categoryName,
                        style: Style.textStyle12grey,
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text("color:", style: Style.textStyle14grey),
                          Text("Black", style: Style.textStyle14Black),
                          SizedBox(width: 20),
                          Text("Size:", style: Style.textStyle14grey),
                          Text("LL", style: Style.textStyle14Black),
                        ],
                      ),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Units:', style: Style.textStyle14grey),
                          Text(
                            widget.product.quantity.toString(),
                            style: Style.textStyle14grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 15),
                child: Text(
                  "${(widget.product.price * widget.product.quantity).toStringAsFixed(2)}\$",
                  textAlign: TextAlign.end,
                  style: Style.textStyle14Black,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 15,
          right: 0,
          child: IconButton(
            onPressed: () {
              context.read<FavoriteCubit>().removeFromFavorites(widget.product);
            },
            icon: Icon(Icons.delete, size: 25),
          ),
        ),
      ],
    );
  }
}
