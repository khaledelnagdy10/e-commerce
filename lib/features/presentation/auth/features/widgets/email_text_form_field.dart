import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.title,
    required this.onChanged,
    this.initialValue,
    this.readOnly = false,
  });

  final String title;
  final Function(String?) onChanged;
  final String? initialValue;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter data';
          }

          final emailRegex = RegExp(r'^[a-zA-Z0-9_-]+@gmail\.com$');

          if (!emailRegex.hasMatch(value)) {
            return 'Email must be a valid Gmail like example@gmail.com';
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
