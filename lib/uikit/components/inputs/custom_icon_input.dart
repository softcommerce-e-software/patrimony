import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/form/controller/custom_icon_select_controller.dart';

class CustomIconInput extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        labelText != null
            ? Text(
                labelText!,
                style: Theme.of(context).textTheme.bodyLarge?.apply(
                      color: Theme.of(context).primaryColorDark,
                    ),
              )
            : const SizedBox(),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.only(bottom: 16),
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                border: Border.all(
                  color: Theme.of(context).disabledColor.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                CustomIconSelectController.instance.icon,
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
