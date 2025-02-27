import 'package:flutter/material.dart';

class CustomRadioGroup<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T selectedValue;
  final ValueChanged<T> onChanged;

  const CustomRadioGroup({
    Key? key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ...options.map((option) {
          return RadioListTile<T>(
            title: Text(option.toString()),
            value: option,
            groupValue: selectedValue,
            onChanged: (value) => onChanged(value!),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          );
        }).toList(),
      ],
    );
  }
}
