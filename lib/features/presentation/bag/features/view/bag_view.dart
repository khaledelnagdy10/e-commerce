import 'package:flutter/material.dart';
import 'package:store_app2/features/presentation/bag/features/widgets/bag_info_body.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 60),
        child: BagInfoBody(),
      ),
    );
  }
}
