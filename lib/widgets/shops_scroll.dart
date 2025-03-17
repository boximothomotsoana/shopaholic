import 'package:auth/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RestaurantScrollView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  // List of restaurants
  final List<Map<String, dynamic>> restaurants = [
    {"name": "Pizza Hut", "image": "assets/images/rr.png"},
    {"name": "Burger King", "image": "assets/images/rr.png"},
    {"name": "Sushi World", "image": "assets/images/rr.png"},
    {"name": "Chick-fil-A", "image": "assets/images/rr.png"},
    {"name": "Braai Masters", "image": "assets/images/rr.png"},
    // Add more restaurants if needed
  ];

  void showRestaurantDetail(BuildContext context, Map<String, dynamic> restaurant) {
    // Show bottom sheet with restaurant details
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Restaurant Image and Name
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(restaurant["image"]),
              ),
              SizedBox(height: 10),
              Text(
                restaurant["name"],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Visit Now Button
              ElevatedButton(
                onPressed: () {
                  // Add the link or navigation for the "Visit Now" action
                  // For example, navigate to the restaurant's page or website
                  print('Visiting ${restaurant["name"]}');
                },
                child: Text("Visit Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return Row(
      children: [
        if (!isMobile) IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.offset - 200,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        Expanded(
          child: Container(
            height: 250,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return GestureDetector(
                  onTap: () => showRestaurantDetail(context, restaurant),
                  child: Container(
                    width: 180,
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.light,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: AppColors.light, blurRadius: 5, spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Circle avatar for restaurant logo
                        ClipOval(
                          child: Image.asset(
                            restaurant["image"],
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Restaurant Name
                        Text(
                          restaurant["name"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(height: 20),
                        // Visit Now Button
                        ElevatedButton(
                          onPressed: () {
                            // Add the link or navigation for the "Visit Now" action
                            // For example, navigate to the restaurant's page or website
                            print('Visiting ${restaurant["name"]}');
                          },
                          child: Text("Visit Now"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.light,
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (!isMobile) IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.offset + 200,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }
}
