import 'package:flutter/material.dart';

class ImageAssets extends StatelessWidget {
  const ImageAssets({super.key, required this.url, required this.fit});
  final String url;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return Image.asset(url, fit: fit);
  }
}
