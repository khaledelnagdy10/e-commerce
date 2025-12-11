import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.title,
    required this.onChanged,
    required this.authType,
    this.initialValue,
    this.readOnly = false,
  });

  final String title;
  final Function(String?) onChanged;
  final String? initialValue;
  final bool readOnly;

  final int authType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        onChanged: onChanged,
        validator: (value) {
          if (authType == 1) {
            if (value == null || value.isEmpty) {
              return "Password is required";
            }
            if (value.length < 6) {
              return "Wrong password";
            }
            return null;
          }

          if (value == null || value.isEmpty) {
            return 'Password is required';
          }

          final passwordRegex = RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$',
          );

          if (!passwordRegex.hasMatch(value)) {
            return 'Password must be at least 8 characters and include uppercase, lowercase and numbers';
          }

          return null;
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelText: title,
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
