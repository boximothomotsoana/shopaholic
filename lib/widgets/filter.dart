import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class RestaurantFilter extends StatefulWidget {
  @override
  _RestaurantFilterState createState() => _RestaurantFilterState();
}

class _RestaurantFilterState extends State<RestaurantFilter> {

  // Filter Options
  RangeValues _priceRange = RangeValues(10, 100); // Example price range
  final List<String> _mealType = [];
  final List<String> _serviceOptions = [];
  bool _openNow = false;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Removes rounded corners
      ),
      backgroundColor: AppColors.light,
      child: ListView(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(color: AppColors.light),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Shop By Category",
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
            // Price Range Slider
            Text(
              "Price Range",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 500,
              divisions: 50,
              labels: RangeLabels('${_priceRange.start}', '${_priceRange.end}'),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),

            Divider(),

            // Meal Type Checkboxes
            Text(
              "Meal Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildCheckbox("Breakfast", _mealType),
            _buildCheckbox("Lunch", _mealType),
            _buildCheckbox("Dinner", _mealType),

            Divider(),

            // Service Options
            Text(
              "Service Options",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildCheckbox("Delivery", _serviceOptions),
            _buildCheckbox("Pick-up", _serviceOptions),
            _buildCheckbox("Dine-in", _serviceOptions),
            _buildCheckbox("Drive-thru", _serviceOptions),

            Divider(),

            // Open Now Switch
            Text(
              "Open Now",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Only Show Open Now'),
              value: _openNow,
              onChanged: (bool value) {
                setState(() {
                  _openNow = value;
                });
              },
            ),

            Divider(),

            // Apply Filters Button
            ElevatedButton(
              onPressed: () {
                // TODO: Implement filter logic
                print('Filters Applied: Price=$_priceRange, Meals=$_mealType, Services=$_serviceOptions, OpenNow=$_openNow');
              },
              child: Text("Apply Filters"),
            ),


        ],
      ),
    );
  }
  // Helper for Checkboxes
  Widget _buildCheckbox(String label, List<String> selectedList) {
    return CheckboxListTile(
      title: Text(label),
      value: selectedList.contains(label),
      onChanged: (bool? value) {
        setState(() {
          if (value == true) {
            selectedList.add(label);
          } else {
            selectedList.remove(label);
          }
        });
      },
    );
  }
}
