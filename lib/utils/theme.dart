import 'package:flutter/material.dart';

class AppTheme {
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  );

  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    backgroundColor: Colors.blue,
  );
}
