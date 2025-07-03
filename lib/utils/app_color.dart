import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColor {
  // Background color for both platforms
  static const backgroundDark = Color(0xFF1A1A1A); // IMDb black/dark gray

  // Accent color for both platforms
  static const accentYellow = Color(0xFFF5C518); // IMDb yellow

  // Card and search bar background
  static const cardBackground = Colors.grey; // Dark gray for cards and search bar

  // Text colors
  static const primaryText = Colors.white; // White for primary text
  static const secondaryText = Colors.grey; // Gray for secondary text (placeholders, ratings)

  // Error color
  static const errorRed = Colors.red; // Red for error icons

  // Button text color
  static const buttonText = Colors.black; // Black for button text

  // Separate Colors for Platforms (retaining original colors)
  static const primaryColorAndroid = Color(0xFF36454F);
  static const primaryColorIOS = CupertinoColors.activeBlue;
}