import 'package:flutter/material.dart';
import 'package:store_app2/core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.width,
    required this.height,
  });
  final void Function() onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: onPressed,
      child: Text(text, style: Style.textStyle16White),
    );
  }
}
