import 'package:flutter/material.dart';

class CustomGridIconItem extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;

  const CustomGridIconItem({super.key, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Icon(
          icon,
          size: 32,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
