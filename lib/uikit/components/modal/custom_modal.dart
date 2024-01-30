import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const CustomModal({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              color: Theme.of(context).primaryColorDark.withOpacity(.50),
            ),
          ),
          Center(child: child),
        ],
      ),
    );
  }
}
