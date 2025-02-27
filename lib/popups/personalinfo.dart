import 'package:flutter/material.dart';
import '../utils/custom_button.dart';
import '../utils/custom_text_field.dart';

class PersonalInfoPopup extends StatefulWidget {
  @override
  _PersonalInfoPopupState createState() => _PersonalInfoPopupState();
}

class _PersonalInfoPopupState extends State<PersonalInfoPopup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If form is valid, process the data (e.g., save it, submit to a server, etc.)
      String name = _nameController.text;
      String surname = _surnameController.text;
      String phone = _phoneController.text;
      String email = _emailController.text;

      print('Name: $name');
      print('Surname: $surname');
      print('Phone: $phone');
      print('Email: $email');

      // Close the popup after submission
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    bool isMobile = MediaQuery.of(context).size.width < 900;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0; // Check if keyboard is open

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      backgroundColor: Colors.white, // Set background color
      child: SingleChildScrollView(
        child: Container(
          width: isMobile? screenWidth * 0.99 : screenWidth * 0.50, // 95% of the screen width
          height: keyboardOpen ? screenHeight * 0.6 : screenHeight * 0.7, // Adjust height when keyboard is open
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button at top-right
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // Popup Title
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Using your CustomTextField widget for form fields
                    CustomTextField(
                      label: 'Name',
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      label: 'Surname',
                      controller: _surnameController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.person_outline,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      label: 'Phone Number',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Submit Button
                        Center(
                        child: CustomButton(
                          text: 'Submit',
                          onPressed: _submitForm, // Your form submission method
                          icon: Icons.check, // Optional: Add an icon to the button
                        )
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
