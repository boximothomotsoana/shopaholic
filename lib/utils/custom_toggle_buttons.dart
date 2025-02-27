import 'package:flutter/material.dart';

class CustomToggleButtons extends StatelessWidget {
  final List<String> options;
  final List<bool> selected;
  final ValueChanged<int> onPressed;

  const CustomToggleButtons({
    Key? key,
    required this.options,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: selected,
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(8),
      borderColor: Colors.blue,
      selectedBorderColor: Colors.blue,
      selectedColor: Colors.white,
      fillColor: Colors.blue,
      children: options.map((option) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text(option),
      )).toList(),
    );
  }
}
