import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Transparent AppBar
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary.withOpacity(0.6),
          elevation: 0,
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Change to your preferred text color
            ),
          ),
        ),

        // Modern Back Button (Floating Above AppBar)
        Positioned(
          left: 16,
          top: 40, // Adjust this based on status bar height
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.arrow_back_ios, color: AppColors.light, size: 24),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
