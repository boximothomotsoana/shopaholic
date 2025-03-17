import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class ProductCategoryWidget extends StatefulWidget {
  @override
  _ProductCategoryWidgetState createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends State<ProductCategoryWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String? _imageError;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
        _imageError = null; // Reset error when image is selected
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product Category")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Category Name Input
              TextFormField(
                controller: _categoryNameController,
                decoration: const InputDecoration(labelText: "Category Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Category name is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: _image == null
                      ? Icon(Icons.camera_alt, size: 50)
                      : kIsWeb
                      ? Image.network(_image!.path, fit: BoxFit.cover)
                      : Image.file(File(_image!.path), fit: BoxFit.cover),

                ),
              ),

              if (_image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Selected Image: $_image"),
                ),

              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    if (_image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Image is required")),
                      );
                      return;
                    }

                    // Form is valid and image is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Category Added!")),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
