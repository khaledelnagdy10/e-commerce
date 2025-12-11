import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    super.key,
    required this.warningText,
    required this.onPressed,
  });
  final String warningText;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      content: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red),
          SizedBox(width: 10),
          Expanded(child: Text(warningText, style: TextStyle(fontSize: 16))),
        ],
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
