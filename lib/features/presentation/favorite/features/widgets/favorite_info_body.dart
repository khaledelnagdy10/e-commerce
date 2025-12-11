import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/features/presentation/favorite/features/controller/Favourite%20cubit/favorite_cubit.dart';
import 'package:store_app2/features/presentation/favorite/features/widgets/favorite_product_card_wide.dart';

class FavoriteInfoBody extends StatefulWidget {
  const FavoriteInfoBody({super.key});

  @override
  State<FavoriteInfoBody> createState() => _FavoriteInfoBodyState();
}

class _FavoriteInfoBodyState extends State<FavoriteInfoBody> {
  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.watch<FavoriteCubit>();
    final favoriteList = favoriteCubit.favoriteProductsList;
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, _) => Divider(),
      itemCount: favoriteList.length,
      itemBuilder: (context, i) {
        final products = favoriteList[i];

        return FavoriteProductCardWide(product: products);
      },
    );
  }
}
