import 'package:auth/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final IconData? icon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.textPrimary, // Default color if none is provided
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24), backgroundColor: AppColors.light, // Increased padding for larger button
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Set button background color to white
        elevation: 5, // Add shadow effect to button
        shadowColor: Colors.grey.withOpacity(0.3), // Custom shadow color
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1), // Optional border for more definition
      ),
      icon: icon != null ? Icon(icon, size: 24, color: AppColors.textPrimary) : SizedBox.shrink(), // Adjust icon size and color
      label: Text(
        text,
        style: TextStyle(
          fontSize: 18, // Increased text size for a bigger button
          color: AppColors.textPrimary, // Button text color
          fontWeight: FontWeight.w500, // Optional: slightly bolder text
        ),
      ),
      onPressed: onPressed,
    );
  }
}
