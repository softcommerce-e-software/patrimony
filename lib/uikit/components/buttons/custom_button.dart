import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? background;
  final Color? textColor;
  final bool isDisable;
  final String buttonText;
  final BuildContext context;

  const CustomButton({
    super.key,
    this.isDisable = false,
    this.textColor,
    this.onPressed,
    required this.context,
    required this.background,
    required this.buttonText,
  });

  final BorderRadius _borderRadius = const BorderRadius.all(
    Radius.circular(12.0),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: _borderRadius,
      child: Ink(
        height: 52.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDisable ? Theme.of(context).disabledColor : background,
          borderRadius: _borderRadius,
        ),
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: onPressed,
          child: Center(
            child: Text(
              buttonText.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.apply(
                    color: textColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
