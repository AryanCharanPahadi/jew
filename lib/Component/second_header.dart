import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Header2 extends StatelessWidget {
  const Header2({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine font size, icon size, and padding based on screen width
    double fontSize = screenWidth <= 200
        ? 12
        : screenWidth <= 250
        ? 14
        : screenWidth <= 300
        ? 16
        : screenWidth <= 600
        ? 20
        : 24;

    double iconSize = screenWidth <= 200
        ? 14
        : screenWidth <= 250
        ? 16
        : screenWidth <= 300
        ? 18
        : 24;

    double horizontalPadding = screenWidth <= 200
        ? 6
        : screenWidth <= 250
        ? 8
        : screenWidth <= 300
        ? 12
        : 16;

    double iconSpacing = screenWidth <= 200
        ? 6
        : screenWidth <= 250
        ? 8
        : 16;

    return Container(
      color: Colors.white,
      height: 70,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                Text(
                  "DAZZLE",
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: GoogleFonts.dancingScript().fontFamily,
                  ),
                ),
                SizedBox(width: screenWidth <= 200 ? 2 : screenWidth <= 250 ? 3 : 5),
                Icon(
                  Icons.diamond,
                  size: iconSize,
                  color: Colors.black,
                ),
              ],
            ),
          ),

          // Icons and Links
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding + 4),
            child: Row(
              children: [
                // Account Icon
                Icon(Icons.person_outline, color: Colors.black, size: iconSize),
                SizedBox(width: iconSpacing),

                // Wishlist Icon
                GestureDetector(
                  onTap: () {
                    context.go('/wishlist');
                  },
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                    size: iconSize,
                  ),
                ),
                SizedBox(width: iconSpacing),

                // Cart Icon
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                  size: iconSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
