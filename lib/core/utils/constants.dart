import 'package:flutter/material.dart';

final kPrimaryColor = Colors.grey.shade200;

abstract class Style {
  static const textStyle12grey = TextStyle(fontSize: 12, color: Colors.grey);

  static const textStyle14grey = TextStyle(fontSize: 14, color: Colors.grey);
  static const textStyle14Black = TextStyle(fontSize: 14, color: Colors.black);
  static const textStyle14White = TextStyle(fontSize: 14, color: Colors.white);

  static const textStyle16Black = TextStyle(fontSize: 16, color: Colors.black);
  static const textStyle16White = TextStyle(fontSize: 16, color: Colors.white);
  static const textStyle20Black = TextStyle(fontSize: 20, color: Colors.black);

  static const textStyle24Black = TextStyle(fontSize: 24, color: Colors.black);

  static const textStyle24White = TextStyle(fontSize: 24, color: Colors.white);
  static const textStyle34White = TextStyle(fontSize: 34, color: Colors.white);
  static const textStyle34Black = TextStyle(fontSize: 34, color: Colors.black);
  static const textStyleAppBarBlack = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );
  static const textStyleBold14Black = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static const textStyleBold16Black = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static const textStyleBold16White = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static const textStyleBold20Black = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const textStyleBold24Black = TextStyle(
    fontSize: 24,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static const textStyleBold24White = TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const textStyleBoldHeadLine = TextStyle(
    fontSize: 35,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static const textStyleBold30White = TextStyle(
    fontSize: 35,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}
