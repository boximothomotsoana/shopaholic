import 'package:flutter/material.dart';

class CustomMultiCheckbox extends StatelessWidget {
  final String label;
  final List<String> options;
  final List<String> selectedValues;
  final ValueChanged<List<String>> onChanged;

  const CustomMultiCheckbox({
    Key? key,
    required this.label,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ...options.map((option) {
          return CheckboxListTile(
            title: Text(option),
            value: selectedValues.contains(option),
            onChanged: (bool? checked) {
              List<String> newValues = List.from(selectedValues);
              if (checked == true) {
                newValues.add(option);
              } else {
                newValues.remove(option);
              }
              onChanged(newValues);
            },
            controlAffinity: ListTileControlAffinity.leading,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          );
        }).toList(),
      ],
    );
  }
}
