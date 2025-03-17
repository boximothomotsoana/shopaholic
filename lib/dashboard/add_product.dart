import 'dart:io'; // Fix for File not being defined
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String _selectedServingOption = "Both";
  List<Map<String, dynamic>> _sizes = [];
  List<Map<String, dynamic>> _addOns = [];
  List<String> _flavors = [];
  List<String> _sauces = [];
  List<String> _extraSides = [];
  String? _imageError;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
        _imageError = null; // Reset error when image is selected
      });
    }
  }

  void _addSize() {
    setState(() {
      _sizes.add({"size": "", "price": ""});
    });
  }

  void _addAddOn() {
    setState(() {
      _addOns.add({"name": "", "price": ""});
    });
  }

  void _addFlavor() {
    setState(() {
      _flavors.add("");
    });
  }

  void _addSauce() {
    setState(() {
      _sauces.add("");
    });
  }

  void _addExtraSide() {
    setState(() {
      _extraSides.add("");
    });
  }

  void _validateAndSave() {
    setState(() {
      _imageError = _image == null ? "Please select an image" : null;
    });

    if (_formKey.currentState!.validate() && _image != null) {
      // If everything is valid, proceed with saving
      print("Product Name: ${_nameController.text}");
      print("Description: ${_descriptionController.text}");
      print("Image Path: ${_image!.path}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product saved successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
      child: Form(
      key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
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
            if (_imageError != null)
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(_imageError!, style: TextStyle(color: Colors.red)),
              ),
            SizedBox(height: 20),
            // Product Name
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Product Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Product name is required";
                }
                return null;
              },
            ),
            SizedBox(height: 10),

            // Product Description
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Description"),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty ? "Description is required" : null,
            ),
            SizedBox(height: 20),
            // Serving Option
            DropdownButtonFormField<String>(
              value: _selectedServingOption,
              items: ["Sit-down", "Takeaway", "Both"].map((option) {
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedServingOption = value!;
                });
              },
              decoration: InputDecoration(labelText: "Serving Option"),
            ),
            SizedBox(height: 20),

            // Sizes
            ..._sizes.asMap().entries.map((entry) {
              int index = entry.key;
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "Size"),
                      onChanged: (val) => _sizes[index]["size"] = val,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "Price"),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => _sizes[index]["price"] = val,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _sizes.removeAt(index);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            ElevatedButton(onPressed: _addSize, child: Text("Add Size")),
            SizedBox(height: 20),
            // Add-ons
            ..._addOns.asMap().entries.map((entry) {
              int index = entry.key;
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "Add-on"),
                      onChanged: (val) => _addOns[index]["name"] = val,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "Price"),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => _addOns[index]["price"] = val,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _addOns.removeAt(index);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            ElevatedButton(onPressed: _addAddOn, child: Text("Add Add-on")),
            SizedBox(height: 20),

            // Flavors
// Flavors
            ..._flavors.asMap().entries.map((entry) {
              int index = entry.key;
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "Flavor"),
                      onChanged: (val) => _flavors[index] = val,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _flavors.removeAt(index);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            ElevatedButton(onPressed: _addFlavor, child: Text("Add Flavor")),
            SizedBox(height: 20),

// Sauces
            ..._sauces.asMap().entries.map((entry) {
              int index = entry.key;
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "Sauce"),
                      onChanged: (val) => _sauces[index] = val,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _sauces.removeAt(index);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            ElevatedButton(onPressed: _addSauce, child: Text("Add Sauce")),
            SizedBox(height: 20),

// Extra Sides
            ..._extraSides.asMap().entries.map((entry) {
              int index = entry.key;
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "Extra Side"),
                      onChanged: (val) => _extraSides[index] = val,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _extraSides.removeAt(index);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            ElevatedButton(onPressed: _addExtraSide, child: Text("Add Extra Side")),
            SizedBox(height: 20),
            // Save Button
            ElevatedButton(
              onPressed: _validateAndSave,
              child: Text("Save Product"),
            ),
          ],
        ),
      )
      ),
    );
  }
}
