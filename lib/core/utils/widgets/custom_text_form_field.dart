import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
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
