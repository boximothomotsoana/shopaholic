import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class EcommerceMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Removes rounded corners
      ),
      backgroundColor: AppColors.light,
      child: ListView(
        padding: EdgeInsets.zero,

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
          _buildMenuItem("Electronics", Icons.devices, [
            _buildSubMenuItem("Phones", [
              _buildSubSubMenuItem("iPhone"),
              _buildSubSubMenuItem("Samsung"),
              _buildSubSubMenuItem("Google Pixel"),
            ]),
            _buildSubMenuItem("Laptops", [
              _buildSubSubMenuItem("MacBooks"),
              _buildSubSubMenuItem("Windows Laptops"),
            ]),
            _buildSubMenuItem("Accessories", [
              _buildSubSubMenuItem("Headphones"),
              _buildSubSubMenuItem("Chargers"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Fashion", Icons.shopping_bag, [
            _buildSubMenuItem("Men's Wear", [
              _buildSubSubMenuItem("Shirts"),
              _buildSubSubMenuItem("Jeans"),
            ]),
            _buildSubMenuItem("Women's Wear", [
              _buildSubSubMenuItem("Dresses"),
              _buildSubSubMenuItem("Shoes"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Home & Furniture", Icons.chair, [
            _buildSubMenuItem("Living Room", [
              _buildSubSubMenuItem("Sofas"),
              _buildSubSubMenuItem("Tables"),
            ]),
            _buildSubMenuItem("Bedroom", [
              _buildSubSubMenuItem("Beds"),
              _buildSubSubMenuItem("Wardrobes"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Appliances", Icons.kitchen, [ // Kitchen appliances icon
            _buildSubMenuItem("Living Room", [
              _buildSubSubMenuItem("Sofas"),
              _buildSubSubMenuItem("Tables"),
            ]),
            _buildSubMenuItem("Bedroom", [
              _buildSubSubMenuItem("Beds"),
              _buildSubSubMenuItem("Wardrobes"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Beauty", Icons.brush, [ // Brush icon for beauty products
            _buildSubMenuItem("Makeup", [
              _buildSubSubMenuItem("Lipstick"),
              _buildSubSubMenuItem("Foundation"),
            ]),
            _buildSubMenuItem("Skincare", [
              _buildSubSubMenuItem("Moisturizers"),
              _buildSubSubMenuItem("Face Masks"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Groceries & Households", Icons.shopping_basket, [ // Grocery basket icon
            _buildSubMenuItem("Food", [
              _buildSubSubMenuItem("Vegetables"),
              _buildSubSubMenuItem("Fruits"),
            ]),
            _buildSubMenuItem("Cleaning Supplies", [
              _buildSubSubMenuItem("Detergents"),
              _buildSubSubMenuItem("Sponges"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Clothing & Shoes", Icons.shopping_bag, [ // Shopping bag icon
            _buildSubMenuItem("Men", [
              _buildSubSubMenuItem("Shirts"),
              _buildSubSubMenuItem("Shoes"),
            ]),
            _buildSubMenuItem("Women", [
              _buildSubSubMenuItem("Dresses"),
              _buildSubSubMenuItem("Heels"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Pets", Icons.pets, [ // Paw icon for pets
            _buildSubMenuItem("Dogs", [
              _buildSubSubMenuItem("Food"),
              _buildSubSubMenuItem("Toys"),
            ]),
            _buildSubMenuItem("Cats", [
              _buildSubSubMenuItem("Litter"),
              _buildSubSubMenuItem("Scratching Posts"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Home & Furniture", Icons.chair, [ // Chair icon for furniture
            _buildSubMenuItem("Living Room", [
              _buildSubSubMenuItem("Sofas"),
              _buildSubSubMenuItem("Tables"),
            ]),
            _buildSubMenuItem("Bedroom", [
              _buildSubSubMenuItem("Beds"),
              _buildSubSubMenuItem("Wardrobes"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Automotive", Icons.directions_car, [ // Car icon for automotive
            _buildSubMenuItem("Car Accessories", [
              _buildSubSubMenuItem("Seat Covers"),
              _buildSubSubMenuItem("Air Fresheners"),
            ]),
            _buildSubMenuItem("Motorcycles", [
              _buildSubSubMenuItem("Helmets"),
              _buildSubSubMenuItem("Gloves"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Baby & Toddler", Icons.child_friendly, [ // Baby-friendly icon
            _buildSubMenuItem("Clothing", [
              _buildSubSubMenuItem("Onesies"),
              _buildSubSubMenuItem("Shoes"),
            ]),
            _buildSubMenuItem("Toys", [
              _buildSubSubMenuItem("Stuffed Animals"),
              _buildSubSubMenuItem("Learning Games"),
            ]),
          ]),
          Divider(),
          _buildMenuItem("Health and Personal Care", Icons.health_and_safety, [ // Health icon
            _buildSubMenuItem("Personal Hygiene", [
              _buildSubSubMenuItem("Toothbrushes"),
              _buildSubSubMenuItem("Shampoo"),
            ]),
            _buildSubMenuItem("Medical Supplies", [
              _buildSubSubMenuItem("Thermometers"),
              _buildSubSubMenuItem("First Aid Kits"),
            ]),
          ]),
        ],
      ),
    );
  }

  // 🔹 Build Main Menu Item (1st Level)
  Widget _buildMenuItem(String title, IconData icon, List<Widget> children) {
    return ExpansionTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: TextStyle(fontSize: 16,)),
      children: children
    );
  }

  // 🔹 Build Submenu Item (2nd Level)
  Widget _buildSubMenuItem(String title, List<Widget> children) {
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: ExpansionTile(
        leading: Icon(Icons.arrow_right, color: Colors.grey),
        title: Text(title, style: TextStyle(fontSize: 14)),
        children: children,
      ),
    );
  }

  // 🔹 Build Sub-Submenu Item (3rd Level)
  Widget _buildSubSubMenuItem(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 32),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 13)),
        onTap: () {
          // TODO: Handle navigation to the product list
        },
      ),
    );
  }
}
