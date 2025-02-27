import 'package:flutter/material.dart';
import '../widgets/menus.dart';
import '../widgets/multi_level_menu.dart';
import 'custom_text_field.dart';
import 'custom_dropdown.dart';
import 'custom_date_picker.dart';
import 'custom_file_picker.dart';
import 'custom_checkbox.dart';
import 'custom_switch.dart';
import 'custom_radio_group.dart';
import 'custom_multi_checkbox.dart';
import 'custom_slider.dart';
import 'custom_toggle_buttons.dart';
import 'custom_stepper.dart';
import 'custom_rating_stars.dart';
import 'custom_button.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  int cartItemCount = 3;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? selectedGender;
  String filePath = "";
  bool acceptTerms = false;
  bool notificationsEnabled = false;
  String selectedOption = "Option 1";
  List<String> selectedHobbies = [];
  double sliderValue = 5.0;
  List<bool> selectedToggles = [true, false, false]; // Default first button selected
  int stepperValue = 1;
  double ratingValue = 3.0;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, spreadRadius: 2, offset: Offset(0, 4)),
          ]),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: TopBar(cartItemCount: cartItemCount, onSearchTap: () {}, onTap: () {  },),
          ),
        ),
      ),
      drawer: isMobile ? EcommerceMenu() : null,
      endDrawer: isMobile ? LeftSideBarMenu() : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600; // Tablet & Desktop Mode
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600), // Max width for large screens
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      CustomTextField(label: "Name", controller: nameController),
                      CustomDropdown(
                        label: "Gender",
                        items: ["Male", "Female", "Other"],
                        selectedValue: selectedGender,
                        onChanged: (value) => setState(() => selectedGender = value),
                      ),
                      CustomDatePicker(label: "Date of Birth", controller: dateController),
                      CustomFilePicker(label: "Upload File", onFileSelected: (path) => setState(() => filePath = path)),
                      CustomCheckbox(
                        label: "Accept Terms & Conditions",
                        value: acceptTerms,
                        onChanged: (value) => setState(() => acceptTerms = value ?? false),
                      ),
                      CustomSwitch(
                        label: "Enable Notifications",
                        value: notificationsEnabled,
                        onChanged: (value) => setState(() => notificationsEnabled = value),
                      ),
                      CustomRadioGroup<String>(
                        label: "Select an Option",
                        options: ["Option 1", "Option 2", "Option 3"],
                        selectedValue: selectedOption,
                        onChanged: (value) => setState(() => selectedOption = value),
                      ),
                      CustomMultiCheckbox(
                        label: "Select Hobbies",
                        options: ["Reading", "Gaming", "Traveling", "Cooking"],
                        selectedValues: selectedHobbies,
                        onChanged: (values) => setState(() => selectedHobbies = values),
                      ),
                      CustomSlider(
                        label: "Select Rating",
                        value: sliderValue,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        onChanged: (value) => setState(() => sliderValue = value),
                      ),
                      CustomToggleButtons(
                        options: ["Low", "Medium", "High"],
                        selected: selectedToggles,
                        onPressed: (index) {
                          setState(() {
                            for (int i = 0; i < selectedToggles.length; i++) {
                              selectedToggles[i] = (i == index);
                            }
                          });
                        },
                      ),
                      CustomStepper(
                        label: "Select Quantity",
                        value: stepperValue,
                        min: 1,
                        max: 10,
                        onChanged: (value) => setState(() => stepperValue = value),
                      ),
                      CustomRatingStars(
                        rating: ratingValue,
                        maxStars: 5,
                        onRatingChanged: (value) => setState(() => ratingValue = value),
                      ),
                      Align(
                        alignment: isWideScreen ? Alignment.center : Alignment.center,
                        child: CustomButton(text: "Submit", onPressed: () {
                          // Handle form submission
                          print("Form Submitted!");
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
