import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/custom_button.dart';

class CustomCarousel extends StatelessWidget {
  final List<Map<String, String>> sliderItems = [
    {
      "title": "Telehealth Services",
      "description": "Connect with doctors anytime, anywhere.",
      "buttonText": "Get Started",
      "image": "assets/images/rr.png"
    },
    {
      "title": "Mental Health Support",
      "description": "Talk to a professional about your mental well-being.",
      "buttonText": "Learn More",
      "image": "assets/images/rr.png"
    },
    {
      "title": "Prescription Delivery",
      "description": "Get your medicines delivered to your doorstep.",
      "buttonText": "Order Now",
      "image": "assets/images/rr.png"
    },
    {
      "title": "Virtual Checkups",
      "description": "Book an online consultation with top specialists.",
      "buttonText": "Book Now",
      "image": "assets/images/rr.png"
    },
    {
      "title": "Health & Wellness Tips",
      "description": "Stay informed with our daily health tips.",
      "buttonText": "Read More",
      "image": "assets/images/rr.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        aspectRatio: 16 / 9,
        autoPlayInterval: Duration(seconds: 4),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
      items: sliderItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              padding: isMobile ? EdgeInsets.symmetric(horizontal: 8) : EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.light,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: isMobile
                    ? Column( // For mobile devices
                  children: [
                    // Image Section
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                      child: Image.asset(
                        item["image"]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 120,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"]!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            item["description"]!,
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                )
                    : Row( // For larger screens
                  children: [
                    // Text & Button Section
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"]!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              item["description"]!,
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 12),
                            Center(
                              child: CustomButton(
                                text: item["buttonText"]!,
                                onPressed: () {}, // Your form submission method
                                icon: Icons.check, // Optional: Add an icon to the button
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Image Section
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Image.asset(
                          item["image"]!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
