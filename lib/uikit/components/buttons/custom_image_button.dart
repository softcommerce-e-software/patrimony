import 'package:flutter/material.dart';

class CustomImageButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? background;
  final Color? textColor;
  final bool isDisable;
  final String buttonText;
  final BuildContext context;
  final String iconPath;

  const CustomImageButton({
    super.key,
    this.isDisable = false,
    this.textColor,
    this.onPressed,
    required this.context,
    required this.iconPath,
    required this.background,
    required this.buttonText,
  });

  final BorderRadius _borderRadius = const BorderRadius.all(
    Radius.circular(10.0),
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
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16.0,
                child: Image.asset(iconPath),
              ),
              const SizedBox(width: 12.0),
              Text(
                buttonText.toUpperCase(),
                style: Theme.of(context).textTheme.titleSmall?.apply(
                      color: textColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
