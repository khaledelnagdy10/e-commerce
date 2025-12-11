import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String url;

  const ProductCard({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = url.startsWith('http');

    return SizedBox(
      height: 180,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: isNetworkImage
            ? Image.network(
                url,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              )
            : Image.asset(url, fit: BoxFit.cover),
      ),
    );
  }
}
