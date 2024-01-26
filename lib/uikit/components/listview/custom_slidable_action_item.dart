import 'package:flutter/material.dart';

class CustomSlidableActionItem extends StatelessWidget {
  final Color? background;
  final Color iconColor;
  final IconData icon;

  const CustomSlidableActionItem({
    super.key,
    this.background,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
    );
  }
}
