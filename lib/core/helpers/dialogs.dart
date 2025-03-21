import 'package:flutter/material.dart';

abstract class LoadingDialog {
  static hide(BuildContext context) {
    Navigator.pop(context);
  }

  static show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              CircularProgressIndicator(),
              Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class AppDialogs {
  static Future<void> error(
    BuildContext context, {
    required String message,
  }) async {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              const Icon(Icons.error, color: Colors.red),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
