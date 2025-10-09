import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(
      {super.key, required List<BottomNavigationBarItem> items});

  @override
  Widget build(BuildContext context) {
    return const CustomBottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined), label: 'Shop'),
      BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined), label: 'Bag'),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline), label: 'Favorites'),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined), label: 'Profile'),
    ]);
  }
}
