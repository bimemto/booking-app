import 'package:flutter/material.dart';

/// App Text Styles
/// Centralized text styles for consistent typography across the app
class AppTextStyles {
  // Hero Text Styles
  static const TextStyle heroLarge = TextStyle(
    color: Colors.white,
    fontSize: 56,
    fontWeight: FontWeight.w400,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static const TextStyle heroMedium = TextStyle(
    color: Colors.white,
    fontSize: 40,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: -0.5,
  );

  // Heading Styles
  static const TextStyle heading1 = TextStyle(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle heading2 = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle heading3 = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  // Body Text Styles
  static const TextStyle bodyLarge = TextStyle(
    color: Colors.white70,
    fontSize: 18,
    fontWeight: FontWeight.w300,
    height: 1.5,
    letterSpacing: 0.2,
  );

  static const TextStyle bodyMedium = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySmall = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // Caption Styles
  static TextStyle captionMedium = TextStyle(
    color: Colors.white.withValues(alpha: 0.7),
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static TextStyle captionSmall = TextStyle(
    color: Colors.white.withValues(alpha: 0.6),
    fontSize: 11,
    fontWeight: FontWeight.w300,
  );

  // Button Text Styles
  static const TextStyle buttonPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.8,
  );

  static const TextStyle buttonSecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.8,
  );

  // Price Text Styles
  static const TextStyle priceLarge = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle priceSmall = TextStyle(
    color: Colors.white.withValues(alpha: 0.7),
    fontSize: 11,
    fontWeight: FontWeight.w300,
  );
}

/// App Button Styles
/// Centralized button styles for consistent UI across the app
class AppButtonStyles {
  // Primary Button (Outlined, Transparent)
  static ButtonStyle primaryOutlined = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: Colors.white, width: 1.5),
    ),
    elevation: 0,
  );

  // Secondary Button (Filled, White)
  static ButtonStyle secondaryFilled = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
  );
}
