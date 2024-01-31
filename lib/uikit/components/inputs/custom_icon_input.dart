import 'package:flutter/material.dart';

class CustomIconInput extends StatefulWidget {
  final String? labelText;
  final EdgeInsets? padding;
  final bool? iconOptions;
  final VoidCallback? onTap;

  const CustomIconInput({
    super.key,
    this.padding,
    this.labelText,
    this.iconOptions,
    this.onTap,
  });

  @override
  State<CustomIconInput> createState() => _CustomIconInputState();
}

class _CustomIconInputState extends State<CustomIconInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.labelText != null
            ? Text(
                widget.labelText!,
                style: Theme.of(context).textTheme.bodyLarge?.apply(
                      color: Theme.of(context).primaryColorDark,
                    ),
              )
            : const SizedBox(),
        GestureDetector(
          onTap: widget.onTap,
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.only(bottom: 16),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                border: Border.all(
                  color: Theme.of(context).disabledColor.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.house,
                size: 32,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
