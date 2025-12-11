import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/utils/constants.dart';
import 'package:store_app2/features/presentation/favorite/features/controller/Favourite%20cubit/favorite_cubit.dart';
import 'package:store_app2/features/presentation/favorite/features/widgets/favorite_info_body.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteInitial) {
            return Center(
              child: const Text(
                'No product Added To Favorites',
                style: Style.textStyleBold24Black,
              ),
            );
          }
          if (state is FavoriteUpdated) {
            if (state.favoriteList.isEmpty) {
              return Center(
                child: const Text(
                  'No product Added To Favorites',
                  style: Style.textStyleBold24Black,
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15,
                  top: 40,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Favorites', style: Style.textStyleBoldHeadLine),
                    FavoriteInfoBody(),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
