import 'package:flutter/material.dart';

class CustomListViewHeader extends StatelessWidget {
  final bool? prefixIcon;
  final IconData? icon;
  final String title;

  const CustomListViewHeader({
    super.key,
    this.prefixIcon = false,
    this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        prefixIcon == true
            ? Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(width: 8),
                ],
              )
            : const SizedBox(),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.apply(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const Spacer(),
        Text(
          'Adicionar',
          style: Theme.of(context).textTheme.bodyMedium?.apply(
                color: Theme.of(context).primaryColorDark,
              ),
        ),
      ],
    );
  }
}
