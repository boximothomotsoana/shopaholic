import 'package:auth/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryScrollView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  // List of restaurant categories
  final List<Map<String, dynamic>> categories = [
    {"name": "Pizzas", "image": "assets/images/rr.png"},
    {"name": "Burgers", "image": "assets/images/rr.png"},
    {"name": "Sushi", "image": "assets/images/rr.png"},
    {"name": "Chicken", "image": "assets/images/rr.png"},
    {"name": "Braai", "image": "assets/images/rr.png"},
    {"name": "Pizzas", "image": "assets/images/rr.png"},
    {"name": "Burgers", "image": "assets/images/rr.png"},
    {"name": "Sushi", "image": "assets/images/rr.png"},
    {"name": "Chicken", "image": "assets/images/rr.png"},
    {"name": "Braai", "image": "assets/images/rr.png"},
    // Add more categories if needed
  ];

  void showCategoryDetail(BuildContext context, Map<String, dynamic> category) {
    // Your logic to show category details
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
              Image.asset(category["image"], height: 150, fit: BoxFit.cover),
              SizedBox(height: 10),
              Text(category["name"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Browse the delicious options under ${category["name"]}."),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Scroll left and right for the categories
  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return Column(
      children: [
        Row(
          children: [
            if (!isMobile)
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: _scrollLeft,
              ),
            Expanded(
              child: Container(
                height: 150,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () => showCategoryDetail(context, category),
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppColors.light,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: AppColors.light, blurRadius: 5, spreadRadius: 2),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(category["image"]),
                            ),
                            SizedBox(height: 10),
                            Text(
                              category["name"],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (!isMobile)
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: _scrollRight,
              ),
          ],
        ),
      ],
    );
  }
}

