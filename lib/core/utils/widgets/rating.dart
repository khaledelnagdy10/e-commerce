import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget ratingStar(num rating) {
  List<Widget> stars = [];
  for (int i = 1; i <= 5; i++) {
    if (rating >= i) {
      stars.add(
        const FaIcon(FontAwesomeIcons.solidStar, size: 14, color: Colors.amber),
      );
    } else if (rating >= i - 0.5) {
      stars.add(
        const FaIcon(
          FontAwesomeIcons.starHalfStroke,
          size: 14,
          color: Colors.amber,
        ),
      );
    } else {
      stars.add(
        const FaIcon(FontAwesomeIcons.star, size: 14, color: Colors.amber),
      );
    }
  }

  return Row(children: stars);
}
