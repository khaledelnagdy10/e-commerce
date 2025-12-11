import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.isSwitched,
    required this.onChanged,
  });
  final bool isSwitched;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        activeTrackColor: Colors.blueGrey,
        value: isSwitched,
        onChanged: onChanged,
      ),
    );
  }
}
