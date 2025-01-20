import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final double fontSize;
  final double padding;
  final Color textColor;
  final Color backgroundColor;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;
  final VoidCallback? onHover; // Nullable onHover callback

  const MenuItem({
    super.key,
    required this.title,
    required this.fontSize,
    required this.padding,
    required this.textColor,
    this.backgroundColor = Colors.transparent, // Default value
    required this.isSelected,
    required this.isDisabled,
    required this.onTap,
    this.onHover, // Optional hover callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: MouseRegion(
        onEnter: (_) {
          if (onHover != null) {
            onHover!(); // Trigger hover if provided
          }
        },
        onExit: (_) {
          if (onHover != null) {
            onHover!(); // Trigger hover out if provided
          }
        },
        child: Container(
          padding: EdgeInsets.all(padding),
          color: isSelected ? Colors.red : backgroundColor, // Red background if selected
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              color: isSelected ? Colors.white : textColor, // White text if selected
              fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
