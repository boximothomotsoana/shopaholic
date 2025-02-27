import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomFilePicker extends StatefulWidget {
  final String label;
  final ValueChanged<String> onFileSelected;

  const CustomFilePicker({Key? key, required this.label, required this.onFileSelected}) : super(key: key);

  @override
  _CustomFilePickerState createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  String fileName = "No file selected";

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
      widget.onFileSelected(result.files.single.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickFile,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(fileName),
            Icon(Icons.attach_file),
          ],
        ),
      ),
    );
  }
}
