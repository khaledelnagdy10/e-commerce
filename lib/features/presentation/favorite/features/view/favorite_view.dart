import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/favorite/features/widgets/favorite_info_body.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 60),
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
}
