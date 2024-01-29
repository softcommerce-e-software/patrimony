import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? background;
  final IconData icon;
  final Color? iconColor;

  CustomIconButton({
    super.key,
    this.onPressed,
    this.background,
    this.iconColor,
    required this.icon,
  });

  final BorderRadius _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 36.0,
      height: 36.0,
      decoration: BoxDecoration(
        color: background ?? Colors.transparent,
        borderRadius: _borderRadius,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: _borderRadius,
        child: Icon(
          icon,
          color: iconColor ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
