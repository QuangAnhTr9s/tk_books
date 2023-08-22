import 'package:flutter/material.dart';

class BackButtonAppBar extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;

  const BackButtonAppBar({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: iconColor,
            size: 14,
          ),
        ),
      ),
    );
  }
}
