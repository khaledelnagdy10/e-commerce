import 'package:flutter/material.dart';
import 'package:store_app2/features/presentation/favorite/features/widgets/favorite_info_body.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 15),
        child: const FavoriteInfoBody(),
      ),
    );
  }
}
