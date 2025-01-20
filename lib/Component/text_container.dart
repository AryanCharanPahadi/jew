import 'package:flutter/material.dart';

class ActionBanner extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color containerColor;
  final Color textColor;
  final double height;
  final Gradient? backgroundGradient; // Background gradient
  final String? fontFamily;           // Font family

  const ActionBanner({
    super.key,
    required this.title,
    this.fontSize = 30.0,
    this.fontWeight = FontWeight.bold,
    this.containerColor = Colors.red,
    this.textColor = Colors.white,
    this.height = 53.0,
    this.backgroundGradient,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine scaling based on screen size
    final isSmallScreen = screenWidth < 600;
    final isExtraSmallScreen = screenWidth < 350;
    final isUltraSmallScreen = screenWidth < 250;

    // Scale dynamically based on screen width
    final adjustedFontSize = isUltraSmallScreen
        ? fontSize * 0.5 // Further reduce for ultra-tiny screens
        : isExtraSmallScreen
        ? fontSize * 0.6 // Reduce for very small screens
        : isSmallScreen
        ? fontSize * 0.8 // Slight reduction for small screens
        : fontSize;

    final adjustedHeight = isUltraSmallScreen
        ? height * 0.5 // Further reduce height
        : isExtraSmallScreen
        ? height * 0.6 // Reduce height for very small screens
        : isSmallScreen
        ? height * 0.8 // Slight reduction for small screens
        : height;

    return Container(
      decoration: BoxDecoration(
        color: backgroundGradient == null ? containerColor : null,
        gradient: backgroundGradient,
      ),
      height: adjustedHeight,
      width: double.infinity,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: adjustedFontSize,
            fontWeight: fontWeight,
            color: textColor,
            fontFamily: fontFamily,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
